Subject: dumb auditdeny question
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 11 Feb 2004 09:03:15 +0100
Message-Id: <1076486595.2415.134.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I wanted to get rid of the following message:

 avc:  denied  { create } for  pid=400 exe=/usr/bin/vim
scontext=kernel_u:kernel_r:kernel_d tcontext=kernel_u:object_r:tcb_t
tclass=file

so I have the following in my policy:

auditdeny kernel_d tcb_t:{ file lnk_file sock_file fifo_file chr_file }
        { ioctl append rename create };

But I still get the message.

What did I do wrong?

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
