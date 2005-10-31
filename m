Subject: Re: unreasonably long SE Linux context display
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: James Morris <jmorris@namei.org>, Daniel J Walsh <dwalsh@redhat.com>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200510311812.02462.russell@coker.com.au>
References: <200510311812.02462.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 11:33:58 -0500
Message-Id: <1130776438.22731.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-31 at 18:11 +1100, Russell Coker wrote:
> It seems to me that one way of improving the situation with ps might be to 
> allow specifying a regex for the context to match in a similar manner to 
> killall (could probably take the same code).  Another possibility is to allow 
> displaying partial contexts.  For example I might want to see the domains 
> used by system processes (role==system_r) but not have the role or identity 
> displayed (because they are not relevant).  Of course we may have great 
> trouble trying to get such changes accepted upstream.
> 
> For ls it would be good to be able to display part of the context.  For the 
> vast majority of invocations of "ls -Z" on a SE Linux system the identity and 
> role are not desired in the output.

James previously suggested introducing environment variables to control
the display of contexts, so that you could alter ls and ps -Z output
simply by adjusting such variables.  This could be implemented in the
utilities themselves (using the libselinux context_* functions to break
down the context), but that would be a fairly extensive set of changes.
It could also be implemented in libsetrans as part of the context
translation support, but that could have interesting side effects, e.g.
if one of these abbreviated contexts is then passed back into another
libselinux function, we can't necessarily determine the right values for
the omitted fields.

In any event, patches speak louder than words here...  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
