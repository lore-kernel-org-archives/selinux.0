Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10998
	for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 11:33:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19447
	for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 15:31:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA19443 for <selinux@tycho.nsa.gov>; Sat, 29 Jun 2002 15:31:56 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Major reduction in errors
Date: Sat, 29 Jun 2002 11:33:19 -0400
Cc: selinux@tycho.nsa.gov
References: <20020629125840.23497.qmail@web40016.mail.yahoo.com>
In-Reply-To: <20020629125840.23497.qmail@web40016.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020629153319.9E302106@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 29 Jun 2002 08:58, Brad Chapman wrote:
>        I'm sorry to keep bothering you like this, sir, but I am still
> getting floods of permission errors for everything. Attached is another
> dmesg output.
>
> Should I continue tweaking coker.com.au/selinux/policy.tgz or investigate
> coker.com.au/selinux/selinux-small?

I suggest investigating the policy that I am distributing (which fixes most 
of the issues you are seeing), as well as the samba policy that has been 
recently posted here.

avc:  denied  { read } for  pid=535 exe=/sbin/insmod path=/.devfsd dev=00:07 
ino=2 scontext=system_u:system_r:insmod_t tcontext=system_u:object_r:devfs_t 
tclass=chr_file

The above is because you are using an old version of devfsd, this bug was 
fixed almost a year ago.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
