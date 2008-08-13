Message-ID: <48A33F0F.3070409@redhat.com>
Date: Wed, 13 Aug 2008 16:07:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Tomas Mraz <tmraz@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Using su with pam_selinux
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

One of the things we figured out early on was that putting pam_selinux
into su/su- pam module caused lots of problems.  Mainly around service
apps executing su in the initcripts.  We used to see things like promprs
for alternate context and default context stoping init scripts from
executing.  runuser which is su without the pam_modules was developed to
work around alot of these problems.  But we eventually removed
pam_selinux from /etc/pam.d/su and /etc/pam.d/su-l altogether.

I have an open bugzilla about vncserver which does not work correctly
The way this is supposed to work is a admin sets up a configuration for
a user and the starts the service.  For each user that is going to run
vncserver it is executes

runuser -l ${USER} -c "cd ~${USER} && [ -r .vnc/passwd ] && vncserver
:${DISP} ${VNCUSERARGS}"

What we would really like here is to have vncserver running as
unconfined_u:unconfined_r:unocnfined_t
or
staff_u:staff_r:staff_t

So I did an experment in Rawhide and changed /etc/pam.d/su-l

 more /etc/pam.d/su-l
#%PAM-1.0
auth		include		su
account		include		su
password	include		su
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session		include		su
# pam_selinux.so open should only be followed by sessions to be executed
in the
user context
session    required     pam_selinux.so open
session		optional	pam_keyinit.so force revoke

Then I had to make several policy changes to get the proper transition
rules and fixes to /etc/selinux/targeted/users/unconfined_u for
initrc_su_t to do the right thing.

This all works now in Rawhide.  But ....

su -l as root is broken.

I have fixes for su -l for a unconfined_u user to somewhat work.  But if
you use sudo to go from staff_u:staff_r:staff_t to
staff_u:unconfined_r:unconfined_t and then as root execute su -l
It gets confused.

In rawhide it sees it self as a unconfined_u process trying to figure
out what is reachable for staff_u:unconfined_r:unconfined_t and says no
domains are reachable.  pam_selinux prompts for the user to choose and
then errors out because there are no valid domains in enforcing mode.

My suggestion would be to add a option to pam_selinux to say do nothing
if there are no valid transitions.  IE Just continue in the current
domain.  Then we could add pam_selinux to the su-l domain.  And
everything should work.  (I hope).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkijPw4ACgkQrlYvE4MpobNwcgCeM9hMwB9qJ1ezB5HQKZyfM/yX
7b8AoMzxj1mKqJIu6McOp1F7ki8kOK0H
=IH2D
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
