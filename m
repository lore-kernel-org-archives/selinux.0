Subject: Re: X policy classes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Eamon Walsh <ewalsh@epoch.ncsc.mil>
In-Reply-To: <40A464EB.5030008@snu.edu>
References: <40A464EB.5030008@snu.edu>
Content-Type: text/plain
Message-Id: <1084536340.17741.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 May 2004 08:05:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-05-14 at 02:19, Joshua Brindle wrote:
> We noticed today that the SE-X policy classes have been merged into the 
> sf.net cvs policy. Is there an ETA on when those will be merged into the 
> kernel headers?

Mea culpa.  I planned on waiting until we had an actual update that
affected the kernel code, e.g. the new netlink classes and permissions
under development by James Morris.  Also, there is a planned overhaul
for the kernel access vectors at some point to prune obsolete
permissions, possibly re-organize the remaining permissions more
sensibly, and deal with known gaps (e.g. we actually do need an execute
permission for packet sockets to deal with mmap'd packet sockets).  The
kernel doesn't need the definitions for the SE-X classes and
permissions, although it is true that the classes do affect any
subsequently defined classes (so this will affect James' netlink
classes; they'll need to be shifted unless we are willing to perturb the
values of the X classes).

> Another idea might be to add the pax class to the standard access_vector 
>   file but I'm not sure how receptive that would be since afaik we are 
> the only ones using it.

We should likely go ahead and merge your pax class and access vector
definition to avoid future changes to its value, as a running SELinux
kernel won't accept a policy reload that changes an existing class value
(since existing code may be using the definition).  Send a current patch
for policy/flask/*.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
