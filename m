Date: Mon, 17 Dec 2001 02:51:14 +0000
From: Dale Amon <amon@vnl.com>
To: SELinux@tycho.nsa.gov
Subject: Can't find libwrap
Message-ID: <20011217025114.GA19124@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm presuming someone else has built against debian sid
and will know how to sort this with the least hassle:

checking for gl_matchc field in glob_t... no
checking whether struct dirent allocates space for d_name... yes
checking for libwrap... configure: error: *** libwrap missing
make: *** [xopenssh-config] Error 1

I'm presuming that it wants libwrap0 and just has the
wrong name?

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
