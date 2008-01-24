Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0OL0589023851
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 16:00:05 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0OL05gt024954
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 21:00:05 GMT
Received: by wr-out-0506.google.com with SMTP id c49so249049wra.21
        for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 13:00:04 -0800 (PST)
Message-ID: <dd18b0c30801241300h268ede8ate8ede4a6999e8223@mail.gmail.com>
Date: Thu, 24 Jan 2008 13:00:03 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: /var
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_28915_21950125.1201208403855"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_28915_21950125.1201208403855
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello im testing out mcs refpolicy, and seem to have
inode_doinit_with_dentry context_to_sid(system_u:object_r:var_run_t:s0-s15:
c0.c255) returned 22 for dev=sda1
ino=1425411 show up in dmesg, I have restorcon -R /var and this message
still shows up. ("I dont know where the s0-s15 came from; maybee my user
file?")
any info would be appreciated.
Thanks;
               --Justin P. Mattock

------=_Part_28915_21950125.1201208403855
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello im testing out mcs refpolicy, and seem to have inode_doinit_with_dentry context_to_sid(system_u:object_r:var_run_t:s0-s15:c0.c255) returned 22 for dev=sda1<br>ino=1425411 show up in dmesg, I have restorcon -R /var and this message still shows up. (&quot;I dont know where the s0-s15 came from; maybee my user file?&quot;)
<br>any info would be appreciated.<br>Thanks; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>

------=_Part_28915_21950125.1201208403855--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
