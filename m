Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6N1bAHa023286
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 21:37:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6N1bADW025668
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 01:37:10 GMT
Received: from mvmail1.mv.cougaarsoftware.com (h-68-165-169-235.SNVACAID.covad.net [68.165.169.235])
        by jazzband.ncsc.mil  with ESMTP id h6N1b8eN025665 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 01:37:08 GMT
From: "Michael Luu" <mluu@cougaarsoftware.com>
To: <selinux@tycho.nsa.gov>
Subject: can't log into machine w/ ssh
Date: Tue, 22 Jul 2003 18:49:58 -0700
Message-ID: <001801c350bc$b91cec20$ef0111ac@mluudt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i've added a new user to my selinux box, and i'm able to log in locally.
however, when log in remotely using ssh, the remote machine
automatically logs me out after i authenticate.  below are the output
from the console, and the output from the /var/log/secure file.

========================
ssh verbose output
========================
[mluu@mluu ~]$ ssh -v mike@myhost.com
OpenSSH_3.4p1, SSH protocols 1.5/2.0, OpenSSL 0x0090602f
debug1: Reading configuration data /home/mluu/.ssh/config
debug1: Applying options for *
debug1: /home/mluu/.ssh/config line 6: Deprecated option "FallBackToRsh"
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Applying options for *
debug1: Rhosts Authentication disabled, originating port will not be
trusted.
debug1: ssh_connect: needpriv 0
debug1: Connecting to myhost.com [192.168.1.225] port 22.
debug1: Connection established.
debug1: identity file /home/mluu/.ssh/id_rsa type 1
debug1: identity file /home/mluu/.ssh/id_dsa type -1
debug1: Remote protocol version 1.99, remote software version
OpenSSH_3.4p1
debug1: match: OpenSSH_3.4p1 pat OpenSSH*
Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_3.4p1
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: server->client aes128-cbc hmac-md5 none
debug1: kex: client->server aes128-cbc hmac-md5 none
debug1: SSH2_MSG_KEX_DH_GEX_REQUEST sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP
debug1: dh_gen_key: priv key bits set: 129/256
debug1: bits set: 1554/3191
debug1: SSH2_MSG_KEX_DH_GEX_INIT sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY
debug1: Host 'myhost.com' is known and matches the RSA host key.
debug1: Found key in /home/mluu/.ssh/known_hosts:42
debug1: bits set: 1585/3191
debug1: ssh_rsa_verify: signature correct
debug1: kex_derive_keys
debug1: newkeys: mode 1
debug1: SSH2_MSG_NEWKEYS sent
debug1: waiting for SSH2_MSG_NEWKEYS
debug1: newkeys: mode 0
debug1: SSH2_MSG_NEWKEYS received
debug1: done: ssh_kex2.
debug1: send SSH2_MSG_SERVICE_REQUEST
debug1: service_accept: ssh-userauth
debug1: got SSH2_MSG_SERVICE_ACCEPT
debug1: authentications that can continue: publickey,password
debug1: next auth method to try is publickey
debug1: userauth_pubkey_agent: testing agent key /home/mluu/.ssh/id_rsa
debug1: authentications that can continue: publickey,password
debug1: try pubkey: /home/mluu/.ssh/id_rsa
debug1: authentications that can continue: publickey,password
debug1: try privkey: /home/mluu/.ssh/id_dsa
debug1: next auth method to try is password
mike@myhost.com's password: 
debug1: ssh-userauth2 successful: method password
debug1: channel 0: new [client-session]
debug1: send channel open 0
debug1: Entering interactive session.
debug1: ssh_session2_setup: id 0
debug1: channel request 0: pty-req
debug1: Requesting X11 forwarding with authentication spoofing.
debug1: channel request 0: x11-req
debug1: Requesting authentication agent forwarding.
debug1: channel request 0: auth-agent-req@openssh.com
debug1: channel request 0: shell
debug1: fd 3 setting TCP_NODELAY
debug1: channel 0: open confirm rwindow 0 rmax 32768
debug1: channel_free: channel 0: client-session, nchannels 1
Connection to myhost.com closed by remote host.
Connection to myhost.com closed.
debug1: Transferred: stdin 0, stdout 0, stderr 121 bytes in 0.2 seconds
debug1: Bytes per second: stdin 0.0, stdout 0.0, stderr 634.7
debug1: Exit status -1
========================
/var/log/secure log file
========================
Jul 22 17:30:35 balboa sshd[3817]: Could not reverse map address
192.168.1.240.
Jul 22 17:30:38 balboa sshd[3817]: Accepted password for mike from
192.168.1.240 port 32804 ssh2
Jul 22 17:30:38 balboa sshd[3817]: fatal: Could not obtain SID for user
mike
Jul 22 17:30:38 balboa sshd[3817]: syslogin_perform_logout: logout()
returned an error

-mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
