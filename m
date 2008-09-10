Subject: Re: semanage fcontext - policy loading
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200809102003.17804.russell@coker.com.au>
References: <200809102003.17804.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 10 Sep 2008 08:12:28 -0400
Message-Id: <1221048748.8658.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-09-10 at 20:03 +1000, Russell Coker wrote:
> Is there some good reason for rebuilding and loading the policy as part of the 
> process of running "semanage fcontext"?
> 
> It makes the process take a long time and doesn't seem to serve any purpose.

See the FIXME comment in libsemanage/src/direct_api.c, and Dan's patch
and subsequent discussion:
http://marc.info/?l=selinux&m=121874340121830&w=2

Unfortunately there remain some problems with the patch, as discussed there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
