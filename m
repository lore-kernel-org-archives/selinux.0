Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA01318
	for <selinux@tycho.nsa.gov>; Sat, 4 May 2002 18:28:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA18600
	for <selinux@tycho.nsa.gov>; Sat, 4 May 2002 22:27:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA18596 for <selinux@tycho.nsa.gov>; Sat, 4 May 2002 22:27:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian User <rogelio@evoworks.evoserve.com>, selinux@tycho.nsa.gov
Subject: Re: context for /dev/.devfsd?
Date: Sat, 4 May 2002 18:01:24 +1000
References: <20020503142855.5CDA381455@coffeesaur2.evoserve.com>
In-Reply-To: <20020503142855.5CDA381455@coffeesaur2.evoserve.com>
MIME-Version: 1.0
Message-Id: <20020504222752.C61EA35C4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 May 2002 00:28, Debian User wrote:
> What should the context be for /dev/.devfsd? I used russels
> devfsd-conflet file in my system and half of the avc denials are gone.
> I am trying to define a proper type .devfsd.
>
> should it be:
>
> type devfsd_control_t, file_type;?

Good idea.

While playing around I added the following to devfs_contexts on a test 
machine:
/.devfsd                system_u:object_r:devfs_control_t

I added the following to types/device.te:
# Type for /dev/.devfsd
type devfs_control_t, file_type;

And the following to domains/program/devfsd.te:
allow devfsd_t devfs_control_t:chr_file { read ioctl };

Then I discovered that /.devfsd is invalid syntax for policy.conf.

Can this be fixed?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
