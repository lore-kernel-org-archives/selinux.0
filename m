Message-ID: <554CA7E9.7000601@tycho.nsa.gov>
Date: Fri, 08 May 2015 08:11:21 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeffrey Vander Stoep <jeffv@google.com>,
 Steve Lawrence <slawrence@tresys.com>
Subject: Re: [PATCH 0/3 v5] libsepol, policycoreutils, and checkpolicy: Add
 support for generating CIL to libsepol and checkpolicy
References: <1427908281-11224-1-git-send-email-jwcart2@tycho.nsa.gov>
 <551C2AFE.5030604@tresys.com>
 <CABXk95CkeVT=HF6z4VkmgTjKeSaGwC3AmFMaeaUTkYHT9Xx2Mw@mail.gmail.com>
In-Reply-To: <CABXk95CkeVT=HF6z4VkmgTjKeSaGwC3AmFMaeaUTkYHT9Xx2Mw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/06/2015 06:33 PM, Jeffrey Vander Stoep wrote:
> I am working on switching AOSP to the upstream selinux project.
> Unfortunately this commit breaks the AOSP build on Mac OS. Darwin has no
> fmemopen. 
> 
> external/selinux/libsepol/src/module_to_cil.c:2927:7: warning: implicit
> declaration of function 'fmemopen' [-Wimplicit-function-declaration]
>         fp = fmemopen(seusers, seusers_len, "r");
>              ^
> external/selinux/libsepol/src/module_to_cil.c:2927:5: error:
> incompatible integer to pointer conversion assigning to 'FILE *' (aka
> 'struct __sFILE *') from 'int' [-Werror,-Wint-conversion]
>         fp = fmemopen(seusers, seusers_len, "r");
>            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> external/selinux/libsepol/src/module_to_cil.c:3017:5: error:
> incompatible integer to pointer conversion assigning to 'FILE *' (aka
> 'struct __sFILE *') from 'int' [-Werror,-Wint-conversion]
>         fp = fmemopen(userx, userx_len, "r");
>            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> external/selinux/libsepol/src/module_to_cil.c:3073:5: error:
> incompatible integer to pointer conversion assigning to 'FILE *' (aka
> 'struct __sFILE *') from 'int' [-Werror,-Wint-conversion]
>         fp = fmemopen(fc, fc_len, "r");
>            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning and 3 errors generated.
> make: ***
> [out/host/darwin-x86/obj32/STATIC_LIBRARIES/libsepol_intermediates/src/module_to_cil.o]
> Error 1

Could we perhaps use this when building on OSX:
https://github.com/NimbusKit/memorymapping
