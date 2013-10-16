Message-ID: <525EE5F8.7010800@tycho.nsa.gov>
Date: Wed, 16 Oct 2013 15:16:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 06/16] libsemanage: Also check for the uppoer bound on
 user ids in login.defs
References: <1368189924-8501-1-git-send-email-bigon@debian.org> <1368189924-8501-7-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-7-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/10/2013 08:45 AM, Laurent Bigonville wrote:
> From: Manoj Srivastava <srivasta@debian.org>
> 
> Some non-Debian packages (like qmail, shudder) create
> users not below MIN_UID, but above MAX_UID, in /etc/login.defs
> (non-system users are supposed to have uids between MIN_UID and
> MAX_UID.
> 
> genhomedircon.c:gethomedirs() checks pwent.pw_uid against MIN_UID in
> /etc/login.defs to exclude system users from generating homedir
> contexts. But unfortunately it does not check it against MAX_UID
> setting from the same file. This gets us lines like the following in
> the contexts/files/file_contexts.homedirs file:
> ,----
> | #
> | # Home Context for user user_u
> | #
> | /var/qmail/[^/]*/.+ user_u:object_r:user_home_t:s0
> | /var/qmail/[^/]*/\.ssh(/.*)? user_u:object_r:user_home_ssh_t:s0
> | /var/qmail/[^/]*/\.gnupg(/.+)? user_u:object_r:user_gpg_secret_t:s0
> | /var/qmail/[^/]* -d user_u:object_r:user_home_dir_t:s0
> | /var/qmail/lost\+found/.* <<none>>
> | /var/qmail -d system_u:object_r:home_root_t:s0
> | /var/qmail/\.journal <<none>>
> | /var/qmail/lost\+found -d system_u:object_r:lost_found_t:s0
> | /tmp/gconfd-.* -d user_u:object_r:user_tmp_t:s0
> `----
> This commit adds checking uid value againt MAX_UID too.

On this one, I had to apply a change on top to avoid build breakage due
to strict warnings:
genhomedircon.c: In function ‘get_home_dirs’:
genhomedircon.c:287:22: error: variable ‘maxuid_set’ set but not used
[-Werror=unused-but-set-variable]
cc1: all warnings being treated as errors
make[2]: *** [genhomedircon.o] Error 1




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
