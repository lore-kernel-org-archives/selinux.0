Subject: Re: What policy is the system running?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Steve G <linux_4ever@yahoo.com>, Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <418961EE.4070008@redhat.com>
References: <20041103185116.24681.qmail@web50606.mail.yahoo.com>
	 <418961EE.4070008@redhat.com>
Content-Type: text/plain
Message-Id: <1099579134.3174.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 09:38:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 17:55, Daniel J Walsh wrote:
> James suggests that we have a table on disk that references the checksum 
> to a name.
> 
> So we could get the checksum from the kernel and then look up the name 
> to display
> to the user.  Could have Makefile and rpm update the policy whenever it 
> is modified.

As I mentioned, I don't believe that this will work, because load_policy
is "patching" the binary policy in-memory to set the boolean values to
the locally configured settings prior to loading it into the kernel. 
Hence, any checksum computed by the kernel will not necessarily
correspond to the checksum of any binary policy file, not even the one
that was loaded.  You would have to update your checksum mapping not
only when the binary policy file was updated, but whenever a boolean
setting was changed.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
