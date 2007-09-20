Date: Thu, 20 Sep 2007 14:16:05 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
Subject: Re: [RFC]integrity: SELinux patch
In-Reply-To: <1190293949.12553.23.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0709201414120.16685@us.intercode.com.au>
References: <1188340501.11528.14.camel@localhost.localdomain>
 <46D4F337.1030704@manicmethod.com>  <1188382494.6129.35.camel@localhost.localdomain>
  <1190230883.7323.3.camel@localhost.localdomain>
 <1190235840.25863.98.camel@moss-spartans.epoch.ncsc.mil>
 <1190252058.7323.33.camel@localhost.localdomain>
 <1190293949.12553.23.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Sep 2007, Stephen Smalley wrote:

> Don't worry about conflicts with pending patches; just make a clean
> patch (where a clean patch follows the usual guidelines and doesn't
> include commented-out code) against some well-defined baseline (linus,
> mm, or selinux.git).  Using the for-akpm branch of selinux.git makes it
> easier for James to merge of course, but as -mm includes that branch, it
> should be the same except as other patches in mm might happen to overlap
> and except as one happens to lag behind the other.

Generally, a patch against the latest Linus git will work fine, as that is 
what -mm is against, and if there are conflicts, they need to be resolved 
there anyway.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
