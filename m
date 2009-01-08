From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] [libsemanage] Also check for the uppoer bound on user ids in /etc/login.defs
References: <1231195520-10286-1-git-send-email-manoj.srivastava@stdc.com>
	<49629037.7020604@redhat.com>
	<87k599fidc.fsf@anzu.internal.golden-gryphon.com>
	<496353FA.5020906@redhat.com>
	<87fxjwlc7f.fsf@anzu.internal.golden-gryphon.com>
	<1231254550.9746.53.camel@localhost.localdomain>
	<4963873A.2040701@redhat.com>
	<87wsd8j6c8.fsf@anzu.internal.golden-gryphon.com>
	<1231333052.16760.14.camel@localhost.localdomain>
	<87priyubui.fsf@anzu.internal.golden-gryphon.com>
	<49651258.9080607@redhat.com>
Date: Thu, 08 Jan 2009 08:33:54 -0600
In-Reply-To: <49651258.9080607@redhat.com> (Daniel J. Walsh's message of "Wed,
	07 Jan 2009 15:36:40 -0500")
Message-ID: <87hc49uast.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

 [Trimming the patch and early discussion]

On Wed, Jan 07 2009, Daniel J Walsh wrote:
> Manoj Srivastava wrote:
>> On Wed, Jan 07 2009, Stephen Smalley wrote:
>>> As Dan pointed out, the UID_MAX value in login.defs is only used by
>>> useradd, and is not even strictly enforced (useradd -u 60002 john works
>>> just fine).  In an environment with a large number of users and a global
>>> user database, you can certainly exceed 60000 users or you may even
>>> happen to generate your uids in a manner that happens to put them all in
>>> the upper part of the uid space.  There are real systems with uids >
>>> 60000 for real users, yet the login.defs UID_MAX value has not been
>>> changed on such systems because it is irrelevant and it isn't enforced
>>> by anything.  So this patch would change behavior of libsemanage on such
>>> systems in an undesirable manner.  And it wouldn't help with cases like
>>> oracle where the pseudo user is added via useradd without any specified
>>> uid at all.

>>> I think Dan's earlier posting gets to more of the fundamental problems
>>> with genhomedircon's heuristics for finding home directory locations,
>>> and we need to address his points if we want it to work in general.

>>         Fair enough. In that case, I would like to point out that the
>>  current situation of only checking UID_MIN is causing actual problems
>>  right now on real user systems, and making genhomedircon to incorrectly
>>  guess where home directories exist.

>>         I'll treat this as an imperfect workaround until we fix
>>  semodule, and then I'll just revert the patch for Debian systems.

> What does the passwd entry that it is getting fooled by look like?  Does
> the account really need a real shell?  IE Do people actually login to
> the home directory?

        I do not have passwd data from the machine in question, though I
 can ask. What I do have are the results of fixfiles relabel / :

,----[ file contexts in /var ]
|  drwxr-xr-x 15 root root  system_u:object_r:home_root_t:s0    4096 Dec 29 13:35 .
|  drwxr-xr-x 21 root root  system_u:object_r:root_t:s0         4096 Dec 29 14:21 ..
|  drwxr-xr-x  2 root root  user_u:object_r:user_home_dir_t:s0  4096 May  7  2008 backups
|  drwxr-xr-x  7 root root  user_u:object_r:user_home_dir_t:s0  4096 Dec 29 14:17 cache
|  drwxr-xr-x 25 root root  user_u:object_r:user_home_dir_t:s0  4096 Dec 29 14:17 lib
|  drwxrwsr-x  2 root staff user_u:object_r:user_home_dir_t:s0  4096 Mar 11  2008 local
|  drwxrwxrwt  2 root root  user_u:object_r:user_home_dir_t:s0  4096 Dec 29 18:14 lock
|  drwxr-xr-x  6 root root  system_u:object_r:var_log_t:s0      4096 Dec 29 18:19 log
|  drwx------  2 root root  system_u:object_r:lost_found_t:s0  16384 May  5  2008 lost+found
|  drwxrwsr-x  2 root mail  user_u:object_r:user_home_dir_t:s0  4096 May  5  2008 mail
|  drwxr-xr-x  2 root root  user_u:object_r:user_home_dir_t:s0  4096 May  5  2008 opt
|  drwxr-xr-x  2 root qmail system_u:object_r:home_root_t:s0    4096 Dec 29 13:38 qmail
|  drwxr-xr-x  7 root root  system_u:object_r:var_run_t:s0      4096 Dec 29 18:14 run
|  drwxr-xr-x  5 root root  user_u:object_r:user_home_dir_t:s0  4096 Dec 29 14:17 spool
|  drwxrwxrwt  3 root root  system_u:object_r:tmp_t:s0          4096 Dec 29 18:06 tmp
`----

        Every time "semanage user" is run, we get:
,----[ contexts/files/file_contexts.homedirs ]
|  #
|  #
|  # User-specific file contexts, generated via libsemanage
|  # use semanage command to manage system users to change the file_context
|  #
|  #
|
|  #
|  # Home Context for user user_u
|  #
|
|  /home/[^/]*/.+  user_u:object_r:user_home_t:s0
|  /home/[^/]*/\.ssh(/.*)? user_u:object_r:user_home_ssh_t:s0
|  /home/[^/]*/\.gnupg(/.+)?       user_u:object_r:user_gpg_secret_t:s0
|  /home/[^/]*     -d      user_u:object_r:user_home_dir_t:s0
|  /home/lost\+found/.*    <<none>>
|  /home   -d      system_u:object_r:home_root_t:s0
|  /home/\.journal <<none>>
|  /home/lost\+found       -d      system_u:object_r:lost_found_t:s0
|
|
|  #
|  # Home Context for user user_u
|  #
|
|  /var/[^/]*/.+   user_u:object_r:user_home_t:s0
|  /var/[^/]*/\.ssh(/.*)?  user_u:object_r:user_home_ssh_t:s0
|  /var/[^/]*/\.gnupg(/.+)?        user_u:object_r:user_gpg_secret_t:s0
|  /var/[^/]*      -d      user_u:object_r:user_home_dir_t:s0
|  /var/lost\+found/.*     <<none>>
|  /var    -d      system_u:object_r:home_root_t:s0
|  /var/\.journal  <<none>>
|  /var/lost\+found        -d      system_u:object_r:lost_found_t:s0
|
|
|  #
|  # Home Context for user user_u
|  #
|
|  /var/qmail/[^/]*/.+     user_u:object_r:user_home_t:s0
|  /var/qmail/[^/]*/\.ssh(/.*)?    user_u:object_r:user_home_ssh_t:s0
|  /var/qmail/[^/]*/\.gnupg(/.+)?  user_u:object_r:user_gpg_secret_t:s0
|  /var/qmail/[^/]*        -d      user_u:object_r:user_home_dir_t:s0
|  /var/qmail/lost\+found/.*       <<none>>
|  /var/qmail      -d      system_u:object_r:home_root_t:s0
|  /var/qmail/\.journal    <<none>>
|  /var/qmail/lost\+found  -d      system_u:object_r:lost_found_t:s0
|  /tmp/gconfd-.*  -d      user_u:object_r:user_tmp_t:s0
|
|
|  #
|  # Home Context for user root
|  #
|
|  /root/.+        root:object_r:sysadm_home_t:s0
|  /root/\.ssh(/.*)?       root:object_r:sysadm_home_ssh_t:s0
|  /root/\.gnupg(/.+)?     root:object_r:sysadm_gpg_secret_t:s0
|  /root   -d      root:object_r:sysadm_home_dir_t:s0
|  /tmp/gconfd-root        -d      root:object_r:sysadm_tmp_t:s0
`----

        This makes the machine unusable when in enforcing mode.
 Additionally, when there was unconfined se-module loaded there were
 unconfined_u instead of user_u as the second and third "users" in this
 file (that is, qmail and whatever added /var/spool).

        You need to hand edit
 $POLICY/contexts/files/file_contexts.homedirs and
 $POLICY/modules/active/file_contexts.homedirs by removing invalid
 entries (mentioning /var).

,----[ semanage user -l ]
|  root            sysadm     s0         s0-s0:c0.c1023                 staff_r sysadm_r system_r
|  staff_u         staff      s0         s0-s0:c0.c1023                 staff_r sysadm_r
|  sysadm_u        sysadm     s0         s0-s0:c0.c1023                 sysadm_r
|  system_u        user       s0         s0-s0:c0.c1023                 system_r
|  unconfined_u    unconfined s0         s0-s0:c0.c1023                 system_r unconfined_r
|  user_u          user       s0         s0                             user_r
`----

,----[ semanage login -l ]
|  __default__               user_u                    s0
|  root                      root                      s0-s0:c0.c1023
|  system_u                  system_u                  s0-s0:c0.c1023
`----

,----[ semodule -l ]
|  dhcp    1.6.0
|  dmidecode       1.3.0
|  gpg     1.6.0
|  mysql   1.8.0
|  netutils        1.6.0
|  ssh     1.10.1
|  sudo    1.3.0
|  tcpd    1.3.0
|  tzdata  1.2.0
`----

        manoj
--
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
