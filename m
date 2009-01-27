MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Enabling the "noatime" option on filesystems...
Date: Tue, 27 Jan 2009 15:40:30 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D052F7BE3@de01exm68.ds.mot.com>
In-Reply-To: <497F641E.9050500@hp.com>
References: <alpine.LFD.2.00.0901271229120.11868@home-av-server.home-av> <497F641E.9050500@hp.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Berger Timothy-TBERGER1" <T.Berger@motorola.com>,
        "Stephens Brad-CBS056" <Brad.Stephens@motorola.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

If I enable the 'noatime' option on all my mounted filesystems, such
that anytime a given file is accessed for "READ", the last access time
is not updated: will this cause any negative impacts to SELinux ?

I am guessing it does NOT, but just wanted to make sure if there are any
impacts... Thanks,

- Rezaul.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
