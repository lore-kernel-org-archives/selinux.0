Subject: secon (Was: Policycoreutils patch)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <445BB803.4050409@redhat.com>
References: <445BB803.4050409@redhat.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 10:54:28 -0400
Message-Id: <1147100068.23640.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-05 at 16:39 -0400, Daniel J Walsh wrote:
> Broken audit2allow into two packages including avc.py so that other 
> tools can use it.
> 
> Began adding code to allow it to analyze AVC message and use plugin 
> architecture to translate avc messages.
> 
> Internationailization code added.
> 
> Some po files translated.
> 
> Fixes for semanage
> 
> Cleanup of code

What is the purpose of the secon utility added by this patch?
Assuming that it is useful, a few quick comments on the implementation:
- The my_getXcon_raw functions should be moved into libselinux (without
the my_ prefix, of course) so that we don't need any code outside of
libselinux directly reading /proc/pid/attr files.
- Falling back to the current context when the exec or fscreate context
is not set is not correct.  Absence of exec or fscreate context just
means that the default policy behavior (e.g. type_transition or default
inheritance) will be applied.  While default inheritance would mean that
the current context is applied for exec, there could be a
type_transition, and it makes no sense at all for fscreate (where
default inheritance combines information from the current context with
the parent directory context).  I think you just want to report NULL /
none or similar to the user.
- The call to selinux_trans_to_raw_context() doesn't make sense since
you are already calling the _raw functions.  If opt->disp_raw is set,
then no further processing should be required, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
