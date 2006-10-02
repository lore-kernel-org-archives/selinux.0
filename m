Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9274PQY002284
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 03:04:25 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9273ndh021882
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 07:03:50 GMT
Received: by py-out-1112.google.com with SMTP id 39so1831517pyu
        for <selinux@tycho.nsa.gov>; Mon, 02 Oct 2006 00:04:25 -0700 (PDT)
Message-ID: <750109470610020004n7ce1873fp2a4ea66b15147cbb@mail.gmail.com>
Date: Mon, 2 Oct 2006 03:04:25 -0400
From: alex323 <alex323@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Trouble installing SELinux on Ubuntu
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am attempting to install SELinux on Ubuntu using the HOWTO guide
located at http://www.lurking-grue.org/selinuxHOWTO.html. I am running
into some trouble.

I have compiled the kernel from sources just as instructed (2.6.17.13)
and I booted into the new kernel with selinux enabled.

>From there I installed the selinux-policy-default package. However
when 'make relabel' starts going, I get errors like this:

inode_doinit_with_dentry context_to_sid(kernel) returned 22 for
dev=sda2 inode=#########

Would anyone know what is going on? I've tried installing selinux for
about 6 hours now and nothing I do seems to work. :(

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
