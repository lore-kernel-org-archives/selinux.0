Subject: Some questions
From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 05 Oct 2001 08:50:53 -0400
Message-Id: <1002286253.1080.18.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've installed the latest version of SELinux in permissive mode.

1. I've noticed no unusual messages in dmesg or /var/log/messages. Does
this mean that my normal activities do not violate any of the new access
restrictions? (So enabling secure mode would not disrupt any of the
things I normally do)?

2. If I toggle fully secure mode, can I reverse this remotely (i.e., ssh
to the host, su, and execute the toggle command again)?

3. SSH no longer recognizes my authorized keys --- I must always enter a
password to use it. I've regenerated the keys several times (putting the
appropriate public keys in 'authorized_keys') without success. I know
the sshd on my system was replaced by another. Does it function
differently? 

Here's a log from the debug mode for ssh (on my home computer, I use the
latest version of ssh and a DSA key):

debug1: authentications that can continue:
publickey,password,keyboard-interactive
debug3: start over, passed a different list
publickey,password,keyboard-interactive
debug3: preferred publickey,keyboard-interactive,password
debug3: authmethod_lookup publickey
debug3: remaining preferred: keyboard-interactive,password
debug3: authmethod_is_enabled publickey
debug1: next auth method to try is publickey
debug2: userauth_pubkey_agent: no keys at all
debug2: userauth_pubkey_agent: no more keys
debug2: userauth_pubkey_agent: no message sent
debug1: try privkey: /home/jsmith/.ssh/identity
debug3: no such identity: /home/jsmith/.ssh/identity
debug1: try privkey: /home/jsmith/.ssh/id_rsa
debug3: no such identity: /home/jsmith/.ssh/id_rsa
debug1: try pubkey: /home/jsmith/.ssh/id_dsa
debug3: send_pubkey_test
debug2: we sent a publickey packet, wait for reply
debug1: authentications that can continue:
publickey,password,keyboard-interactive
debug2: userauth_pubkey_agent: no more keys

-- 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
