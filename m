Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA17311
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 20:28:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA20234
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 01:26:01 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id BAA20222
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 01:25:59 GMT
Date: Wed, 20 Nov 2002 12:30:48 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: conflicting header files
Message-ID: <20021120013048.GA31968@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

In lsm-2.4/security/selinux/include/linux/flask/security.h, it has:

int security_compute_av(
        security_id_t ssid,                     /* IN */
        security_id_t tsid,                     /* IN */
        security_class_t tclass,                /* IN */
        access_vector_t requested,              /* IN */
        access_vector_t *allowed,               /* OUT */
        access_vector_t *decided,               /* OUT */
        access_vector_t *auditallow,            /* OUT */
        access_vector_t *auditdeny,             /* OUT */
        __u32 *seqno);                  /* OUT */

int security_sid_to_context(
        security_id_t  sid,                     /* IN */
        security_context_t *scontext,           /* OUT */
        __u32   *scontext_len);                 /* OUT */

In selinux-small-2002102211/libsecure/include/ss.h, it has:

extern int security_compute_av(struct security_query *query,
                                struct security_response *response);

extern int security_sid_to_context(security_id_t sid, 
                                    security_context_t scontext, 
                                    __u32 *scontext_len);

In one my attempts to compile SE-Linux using autoconf, the compiler
included both definitions and complained that they were different.

Is it intended, and if so why?

I am guessing for now that one function is a internal function in the
kernel, and the other function is one defined in libsecure.a for
external use. Am I correct?
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
