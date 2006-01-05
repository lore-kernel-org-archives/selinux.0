Subject: Re: SELinux metadata protection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>,
   linux-security-module@wirex.com, selinux@tycho.nsa.gov
In-Reply-To: <20060105145636.GB23146@sergelap.austin.ibm.com>
References: <200601021906.k02J6HmB009362@luminouswebdesign.com>
	 <1136303210.27632.65.camel@moss-spartans.epoch.ncsc.mil>
	 <20060105145636.GB23146@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 10:10:56 -0500
Message-Id: <1136473856.27632.399.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-05 at 08:56 -0600, Serge E. Hallyn wrote:
> Looking at the second "application note" for 5.3.4.1 of PP_MLOSPP_MR
> (from http://niap.nist.gov/cc-scheme/pp/PP_MLOSPP-MR_V1.22.html), it
> says:
> 
> "The MAC policy covers all subjects and all objects.  The list of
> objects must include object attributes that are themselves objects
> (such as filenames) because they can be manipulated by a user."
> 
> So it sounds like to meet this profile, we'd have to either have
> separate controls on the filename, or extend a file's read/write
> access rights to any dentry pointing to the inode.

I don't think so.  You would just argue that filenames are not separable
objects in Unix/Linux, that they are part of the content of directory
objects in Unix/Linux, and that MAC policy does control the ability to
read directories based on their label.  Further, MAC policy does already
control the ability to modify directories not only based on checks on
the directory label but also based on per-file checks (e.g. SELinux
checks rename, unlink, and link permissions on the inode in addition to
add_name/remove_name on the directory).  The unlink/link checks are
justified since they alter inode state (link count).  The rename check
is more of an integrity-oriented control.
 
> Of course I'd resigned myself long ago to not being able to meet this
> application note :)  Particularly due to the aforementioned hard-to-
> handle information leak on touch(/var/somefilename).  So I'm not
> arguing with the decision to abort this patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
