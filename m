Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBBGqwjU002530
	for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2011 11:53:03 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pBBGr1Tb013277
	for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2011 16:53:02 GMT
Received: by eaan11 with SMTP id n11so419169eaa.12
        for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2011 08:53:01 -0800 (PST)
Date: Sun, 11 Dec 2011 17:51:53 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Proper use of get_default_context
Message-ID: <20111211165153.GA18954@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I'm trying to debug a (less important) case of SSHd segfaulting when the
user is running in permissive mode but has a wrongly labeled system,
resulting in the sshd binary running in the kernel_t context. It looks like
this causes a double-free (or something similar) [1] in the code and I'm
trying to figure out how to best deal with this.

[1] https://bugs.gentoo.org/show_bug.cgi?id=377203

>From the looks of it, I think it boils down to get_default_context which
returns -1 (as expected) but either leaves the security_context_t as-is or
makes it NULL.

 98 int get_default_context(const char *user,
 99                         security_context_t fromcon, security_context_t * newcon)
100 {
101         security_context_t *conary;
102         int rc;
103 
104         rc = get_ordered_context_list(user, fromcon, &conary);
105         if (rc <= 0)
106                 return -1;
107 
108         *newcon = strdup(conary[0]);
109         freeconary(conary);
110         if (!(*newcon))
111                 return -1;
112         return 0;
113 }

Am I correct to state that, if the newcon variable was not set to a valid
security_context_t before, then I can just set newcon to NULL?

Like in OpenSSH's ssh_selinux_getctxbyname:

  static security_context_t ssh_selinux_getctxbyname(char *pwname) {
    security_context_t sc;
    ...
    r = get_default_context(pwname, NULL, &sc);

    return(sc);
  }

I think the above might be updated with:

  if (r != -1)
    return(sc);
  else
    return(NULL);

Otherwise a later call tries to freecon(sc) which then fails (in case of
OpenSSH, that's in ssh_selinux_setup_exec_context()).

Am I making sense here?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
