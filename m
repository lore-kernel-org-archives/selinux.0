Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   fedora-selinux-list@redhat.com
In-Reply-To: <20050328195450.GH3430@lkcl.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <20050328100449.GC3430@lkcl.net>
	 <1112016992.2914.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328182714.GG3430@lkcl.net>
	 <1112034219.2914.117.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328195450.GH3430@lkcl.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 14:46:06 -0500
Message-Id: <1112039166.2914.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 20:54 +0100, Luke Kenneth Casson Leighton wrote:
>  ... there's nothing special needed? ... 
>  
>  oh - yes, i get it.  create filetype.
>  nothing to do with file_type_auto_trans itself.

file_type_auto_trans() is a macro that expands to file_type_trans() and
a type_transition rule specifying the default type for the new files.
file_type_trans() is a macro that expands to the set of allow rules
needed for the domain to create the file (including appropriate
permissions to the parent directory as well as to the file).  The allow
rules are always needed for such a file creation to occur.  The
type_transition rule specifies a default in the absence of anything
specified by the program via setfscreatecon(3).  The ability to use
setfscreatecon(3) does require that the domain have one additional
permission, setfscreate, but the permission checks governing the actual
file creation are the same.

This is a general principle in SELinux; the same set of permission
checks are applied for operations regardless of whether the type was
application-specified or a default value, so that you can always
determine what is permissible via the allow rules.  The same is true of
exec transitions for processes.  The set of permission checks doesn't
change; only the types involved change.
 
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
