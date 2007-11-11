Date: Mon, 12 Nov 2007 09:31:44 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v6 08/13] SELinux: Add new peer permissions to the
 Flask definitions
In-Reply-To: <20071109212433.31738.71161.stgit@flek.americas.hpqcorp.net>
Message-ID: <Xine.LNX.4.64.0711120926410.7114@us.intercode.com.au>
References: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
 <20071109212433.31738.71161.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Nov 2007, Paul Moore wrote:

> Add additional Flask definitions to support the new "peer" object class.

Should this be dependent on dynamic class/permission support?

Or, will these checks only be invoked if labled networking is configured?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
