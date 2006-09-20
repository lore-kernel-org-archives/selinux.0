Subject: Re: run_init requires full path.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45115E89.7060209@redhat.com>
References: <45115E89.7060209@redhat.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 17:07:24 -0400
Message-Id: <1158786444.15340.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-20 at 11:30 -0400, Daniel J Walsh wrote:
> Why does run_init require me to have the full path?  Is there a security 
> reason for this?
> 
> The basic problem is run_init, does a chdir("/") before execing the app.
> 
> So if I want to run a test script
> run_init test.sh or
> run_init ./test.sh
> 
> does not work.
> 
> I end up having to do
> run_init `pwd`/test.sh

See:
http://marc.theaimsgroup.com/?l=selinux&m=102077444021285&w=2

Otherwise, it is quite common to run into audit noise when the init
script or daemon tries to access the cwd.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
