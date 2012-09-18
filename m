Message-ID: <5058A8E4.6080105@manicmethod.com>
Date: Tue, 18 Sep 2012 13:01:24 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: Robert Craig <robertpcraig@gmail.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: signature clause in mac_permisions
References: <CAFftDdrSzB2Os0YbOZyHWSCoy64SGaaV9-jCTFLw5Ozn3KGSsw@mail.gmail.com> <CADQgGG1735_t8q=mA4hhGDPjkziviHE64hAJf2r0pMgjeiji=Q@mail.gmail.com> <CAFftDdotOM8pyZVJ_g0_56L3382uTvq+JpGsqzioJc+MRdXDKw@mail.gmail.com>
In-Reply-To: <CAFftDdotOM8pyZVJ_g0_56L3382uTvq+JpGsqzioJc+MRdXDKw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you want to go straight from cert to hex encoding without having to 
sign an app (i.e., you are generating certs and policies at the same 
time) you can use this:

$openssl x509 -inform PEM -in <certname>.x509.pem -outform DER

Script to encode:

#!/usr/bin/env python

import sys
content = sys.stdin.read().strip()
foo = content.encode("hex")
sys.stdout.write(foo)


The script to encode has to be very careful about padding or null 
terminating, hence why I couldn't just use some random command line tool.

William Roberts wrote:
> I should have RTFM, it is right on the wiki under install time mac
> http://selinuxproject.org/page/SEAndroid
>
>
>
> On Mon, Sep 17, 2012 at 4:22 PM, Robert Craig <robertpcraig@gmail.com
> <mailto:robertpcraig@gmail.com>> wrote:
>
>     Just run the setool host tool. To build just 'make setool' and then
>     to run just 'setool'. The help usage statement will guide you.
>
>
>     On Mon, Sep 17, 2012 at 2:34 PM, William Roberts
>     <bill.c.roberts@gmail.com <mailto:bill.c.roberts@gmail.com>> wrote:
>
>         How did you guys generate the hex encoded x509 string for a
>         signature clause in mac_permissions.xml?
>
>         Did you use the Android "dumpkey.jar"?
>
>         I have the signed apk's, the keystore used to sign them, .pem
>         files which have all the pub keys in them and a p12 and p8 file.
>
>         Which one should I use?
>
>         --
>         Respectfully,
>
>         William C Roberts
>
>
>
>
>
>
> --
> Respectfully,
>
> William C Roberts
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
