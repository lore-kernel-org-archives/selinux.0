Date: Mon, 28 Mar 2005 20:54:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   fedora-selinux-list@redhat.com
Subject: Re: Desktop apps interoperability
Message-ID: <20050328195450.GH3430@lkcl.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <20050328100449.GC3430@lkcl.net> <1112016992.2914.19.camel@moss-spartans.epoch.ncsc.mil> <20050328182714.GG3430@lkcl.net> <1112034219.2914.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112034219.2914.117.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 28, 2005 at 01:23:39PM -0500, Stephen Smalley wrote:
> On Mon, 2005-03-28 at 19:27 +0100, Luke Kenneth Casson Leighton wrote:
> >  ... question: in what ways do you ensure that a security-aware
> >  compromised program is only allowed to create certain filetypes?
> 
> In the same manner as with a security-unaware program; the domain must
> be allowed create permission to the file type via an allow rule.
 
 ... there's nothing special needed? ... 
 
 oh - yes, i get it.  create filetype.
 nothing to do with file_type_auto_trans itself.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
