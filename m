Subject: Re: Shell redirection and denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kroum Antov <kroum@voicecho.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <7D474B714E434FEBACADBB6F98F49BFE@HomePC>
References: <1191870537.14569.23.camel@localhost.localdomain>
	 <470B8EF7.5030102@redhat.com>
	 <1191948913.24970.135.camel@moss-spartans.epoch.ncsc.mil>
	 <7D474B714E434FEBACADBB6F98F49BFE@HomePC>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 08:00:16 -0400
Message-Id: <1192017616.2687.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-10 at 00:10 -0700, Kroum Antov wrote:
> Dan's suggestion for dropping checks entirely on inheritance and transfer of 
> descriptors and do check for OPEN instead
> seems to be solid and simple solution.
> I don't see any potential security danger in doing this. Once an application 
> has the proper rights on a descriptor it can do anything with it anyway. By 
> passing the descriptor to other applications and allowing them to work with 
> this descriptor without problems there is No security issue with this.
> Controlling the Open of the confined applications is sufficient in my 
> opinion.

Not if you want to be able to claim that the system enforces mandatory
access control.  The ability to leak a descriptor at will (unwittingly
or maliciously) to an unauthorized entity violates the principles of
mandatory access control.  And SELinux controls on descriptor
inheritance have caught any number of unwitting leaks of descriptors by
programs.

> Introducing transfer_read and transfer_write permissions will do the work 
> too but in my opinion introduces unnecessary complexity to an already 
> complex system.
> 
> SElinux has potential beyond the standard security control but these AVC 
> denials for file descriptors and ports transfers are greatly limiting the 
> SELinux usability.
> 
> I surely would like to see this issue addressed soon.

Splitting the permissions to allow distinctions to be made is ok, but
entirely dropping the ability to control propagation of access rights is
not.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
