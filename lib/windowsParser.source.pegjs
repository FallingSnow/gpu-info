Start
    = Program

Program
    = headers: Headers GPUS: GPUS.*{

        // Hack for length of last header: last header is not long enough
        headers[headers.length - 1] += ' '.repeat(1000);

        let output = [];
        for (let gpuIndex in GPUS) {
            output[gpuIndex] = {};
            let offset = 0;
            for (let key of headers) {
                output[gpuIndex][key.trim()] = GPUS[gpuIndex].substr(offset, key.length).trim();
                offset += key.length;
            }
        }
        return output;
    }

Headers
    = l: Line LineTerminator + {
        return l;
    }

GPUS
    = l: MergedLine + {
        return l;
    }

Line = UntrimmedWord +

    MergedLine = w: UntrimmedWord + LineTerminator + {
        return w.join("");
    }

UntrimmedWord = fs: (WhiteSpace * ) ? w : Char + ls: (WhiteSpace * ) ? {
    return fs.join("") + w.join("") + ls.join("");
}

Char = c: [ ^ \r\ n\ t] {
    return c;
}

LineTerminator
    = [\n\ r\ u2028\ u2029]

WhiteSpace "whitespace" = "\t" /
    "\v" /
    "\f" /
    " " /
    "\u00A0" /
    "\uFEFF" /
    Zs

// Separator, Space
Zs = [\u0020\ u00A0\ u1680\ u2000 - \u200A\ u202F\ u205F\ u3000]
