Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   fedora-selinux-list@redhat.com
In-Reply-To: <20050328100449.GC3430@lkcl.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <20050328100449.GC3430@lkcl.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 08:36:32 -0500
Message-Id: <1112016992.2914.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 11:04 +0100, Luke Kenneth Casson Leighton wrote:
> On Sun, Mar 27, 2005 at 11:57:35PM -0500, Ivan Gyurdiev wrote:
> 
> > There can't be more than one file_type_auto_trans on the same folder
> > type (right?). 
> 
>  bizarrely, no.
> 
>  i believe this issue was raised some months ago, with the
>  "alternative file context" thing.
> 
>  if file_type_auto_trans also took an executable [domain] as an
>  additional argument, i believe you stand a chance of achieving
>  what you seek.

file_type_auto_trans() is based on the domain of the creating process,
the type of the parent directory, and optionally the class of the new
file.  Hence, you can specify different types on the same "folder" type
as long as the programs run in different domains.  If instead both
programs run in the same domain and are acting on the same directory
type and creating the same class of file, you have to make the program
security-aware if you want to use multiple types on the files (or
similarly, if you have a single program that creates multiple files in
the same directory and you want them to have different types, the
program needs to be security-aware, as with the /etc/passwd
and /etc/shadow type preservation issue).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
