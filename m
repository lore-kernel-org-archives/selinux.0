Date: Wed, 16 Jan 2008 11:58:36 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
        Trond.Myklebust@netapp.com, npiggin@suse.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 00/26] Permit filesystem local caching
In-Reply-To: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
Message-ID: <Xine.LNX.4.64.0801161156410.24959@us.intercode.com.au>
References: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Jan 2008, David Howells wrote:

> The SELinux base code will also need updating to have the security class, lest
> the following error appear in dmesg:
> 
> 	context_struct_compute_av:  unrecognized class 69

Alternately, what's needed is a newer policy which supports unknown 
permission classes.  Any recent distro policy should have this.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
