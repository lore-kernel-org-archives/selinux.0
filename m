MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Setting login context for multiple Linux users using single semanage command...
Date: Mon, 21 Jul 2008 13:41:37 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D04BF2AB9@de01exm68.ds.mot.com>
In-Reply-To: <1216402217.17602.324.camel@moss-spartans.epoch.ncsc.mil>
References: <487F93C3.1040701@redhat.com>  <4880B872.20202@manicmethod.com> <1216402217.17602.324.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

If I wanted to map multiple Linux users (Test1, Test2, and Test3), to a
single SELinux user (staff_u),

Can I use a single semanage command to do this, instead of executing
multiple semanage commands?

In other words,instead of executing:  
semanage login -a -s staff_u Test1
semanage login -a -s staff_u Test2
semanage login -a -s staff_u Test3

Can I do something like:   semanage login -a -s staff_u 'Test1 Test2
Test3'

Thanks as always for your help,

- Rezaul.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
