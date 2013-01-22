Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MFB4Cx017498
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:11:05 -0500
Message-ID: <50FEAC01.3080605@redhat.com>
Date: Tue, 22 Jan 2013 10:10:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Hung Truong <hung.truong@tridsys.com>
CC: "Vu, Joseph" <joseph.vu@boeing.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Turn off "dontaudit" rules in monolithic policy
References: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com> <756D04455A661C4CA25DC5BA4902A7A70130D8@XCH-PHX-204.sw.nos.boeing.com> <d2ec19d66b29b9d3206b49e021bd9aff@mail.gmail.com>
In-Reply-To: <d2ec19d66b29b9d3206b49e021bd9aff@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 01/22/2013 09:31 AM, Hung Truong wrote:
> I am using version 3.7.19-155el6.6.
> 
> 
> 
> *From:*Vu, Joseph [mailto:joseph.vu@boeing.com
> <mailto:joseph.vu@boeing.com>] *Sent:* Tuesday, January 22, 2013 9:19 AM 
> *To:* Hung Truong; SELinux *Subject:* RE: Turn off "dontaudit" rules in
> monolithic policy
> 
> 
> 
> Hung,
> 
> 
> 
> I have been trying to rebuild monolithic policy and was not able to.
> 
> What version of SELinux Policy and RHT are you using?
> 
> 
> 
> --------------------------------------------------------------------------------
>
>  *From:*owner-selinux@tycho.nsa.gov <mailto:owner-selinux@tycho.nsa.gov> 
> [mailto:owner-selinux@tycho.nsa.gov] *On Behalf Of *Hung Truong *Sent:*
> Monday, January 21, 2013 11:25 AM *To:* SELinux *Subject:* Turn off
> "dontaudit" rules in monolithic policy
> 
> 
> 
> I have a custom monolithic build based on RHEL6 policy. I get this error
> when try to turn off dontaudit rules:
> 
> $ semodule -DB
> 
> 
> libsemanage.semanage_link_sandbox: Could not access sandbox base file 
> /etc/selinux/targeted/modules/bmp/base.pp. (No such file or directory)
> 
> Is there other way to turn off dontaudit rules in a monilithic policy?
> 
> 
> 
> Many thanks,
> 
> --Hung Truong
> 
Why not compile two policies one with and one without dontaudit rules?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+rAEACgkQrlYvE4MpobMNDgCfaLNiljkPI6ilm65DgUSBCHmP
W10An1cOKmfs7qCG8xEKaEwjVguLMLZU
=MkCV
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
