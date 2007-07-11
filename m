Message-ID: <4694D18A.9030502@manicmethod.com>
Date: Wed, 11 Jul 2007 08:48:10 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: using semodule_package
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB6DF2@blums0008.bluelnk.net> <1184156241.3392.41.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1184156241.3392.41.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-07-10 at 19:10 -0700, Clarkson, Mike R (US SSA) wrote:
>   
>> The manpage for semodule_package gives examples for how to use it:
>> 	semodule_package -o httpd.pp -m httpd.mod -f httpd.fc
>>
>> Am I supposed to get the *.mod files for modules when I compile the
>> policy? I have a base.mod file, but no *.mod files for the loadable
>> modules. The closest that I have is <module_name>.mod.role files under
>> the .../policy/tmp directory.
>>
>> I'd like to be able to use semodule_package to update file contexts
>> without having to recompile.
>>     
>
> It appears that the .mod files are removed at the end of the build
> process after they have been packaged into .pp files.  Not sure why.
>   

Its a feature of make, all intermediate files without a specific target 
are deleted after the build process. This use to be preventable by 
adding .secondary to the Makefile but there has been a long standing bug 
that keeps that from working.

> Options, aside from tracking down the relevant makefile rule and
> removing it, might include:
> - regenerating the .mod via checkmodule on tmp/<name>.tmp, e.g.
> 	checkmodule -M -m tmp/zebra.tmp -o tmp/zebra.mod
> or
> - extracting the already built .mod file from the .pp file
>
> I took the semodule_package.c code once and created a
> semodule_unpackage.c file from it to unpack the .mod file, but never got
> around to generalizing it (e.g. unpacking all of the files) or
> committing it.  Attached below for your amusement.
> $ gcc -lsepol -o semodule_unpackage semodule_unpackage.c
> $ ./semodule_unpackage zebra.pp zebra.mod
>  
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
