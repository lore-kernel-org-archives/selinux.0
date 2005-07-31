Date: Sun, 31 Jul 2005 11:59:27 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With these patches, on a 64-bit system, after boot:

  
            #objs  objsize   kernmem
Targeted:
  Before:  237888       40     9.1MB
  After:    19968       24     468KB

Strict:
  Before:  571680       40   21.81MB
  After:   221052       24    5.06MB

-- 
James Morris
<jmorris@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
