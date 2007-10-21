Date: Mon, 22 Oct 2007 06:59:52 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
        Andrew Morgan <morgan@kernel.org>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
Subject: Re: Dealing with 64-bit capabilities
In-Reply-To: <20071017140325.GC25692@sergelap.austin.ibm.com>
Message-ID: <Xine.LNX.4.64.0710220658290.30363@us.intercode.com.au>
References: <1192549264.8702.113.camel@moss-spartans.epoch.ncsc.mil>
 <20071016193411.GC4115@sergelap.austin.ibm.com>
 <1192626011.20908.1.camel@moss-spartans.epoch.ncsc.mil>
 <20071017140325.GC25692@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Oct 2007, Serge E. Hallyn wrote:

> Judging by
> http://www.uwsg.iu.edu/hypermail/linux/kernel/9810.2/0705.html,
> the option was actually introduced in 1998 because the use of
> the struct was broken.  Given that, are there any objections to the
> following patch?

Not from me.


Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
