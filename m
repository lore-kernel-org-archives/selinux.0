Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IEG6rT017179
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 10:16:06 -0400 (EDT)
Received: from smtp-mclean.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5IEG3rD019617
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 14:16:03 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id i5IEOJ830768
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 10:24:19 -0400
Received: from MAILHUB2 (mailhub2.mitre.org [129.83.221.18])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id i5IEOJJ30762
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 10:24:19 -0400
From: "Charles M. Schmidt" <cmschmidt@mitre.org>
To: <SELinux@tycho.nsa.gov>
Subject: Questions on SID, TYPE_CHANGE, and user transitions
Date: Fri, 18 Jun 2004 09:15:58 -0500
Message-ID: <001301c4553e$c7466830$6400a8c0@MITRE.ORG>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Howdy,

I have several questions about SELinux configuration. I'm pretty sure none
of these were answered anywhere else, but I appologize if I overlooked an
information source.

SIDs - My understanding of the SID directive is that it is used to associate
"entities" with security contexts at startup. However, I am confused as to
exactly what these "entities" are. Specificially, I am wondering about the
meaning of the first argument to the SID directive. (Ie. in "sid unlabeled
system_u:object_r:unlabeled_t" what does "unlabeled" refer to?) As far as I
can tell, these identifiers do not map to anything else in the policy file.
What entities are receiving these initial contexts? Do these directives have
hardcoded meanings (like the CLASS directives)?

TYPE_CHANGE - I have read the documentation as well as a number of posts to
this list regarding the TYPE_CHANGE directive, but have to admit that it
still has me confused. I understand that it does not force type transitions
(differing from  TYPE_TRANSITION directives) and does not grant any
permissions to allow type (similar to TYPE_TRANSITION directives). I've also
read that it is "used by security aware applications to define relabling
behavior", but I guess I am not certain of what that means. If a security
aware application wishes to transition  itself or a child to a new type, why
doesn't it just do so on its own? Why would it need to look at the
TYPE_CHANGE directives to do this? And why would an automatic transition be
inappropriate? An example might be helpful here.

USER - Actually, less of a question about the directive and more of a
question as to how user identities are handled. My understanding is that,
when a user logs into SELinux, the security kernel looks at the Linux
username the user logged in under and checks to see if it has any USER
directives with identities that match that name. If so, the matching SELinux
identity is used. Otherwise, the user_u user identity is used. (Correct?)
What processes/applications are allowed to change the user identity in this
way?

I have a couple examples of my confusion regarding identity transitions.
Specifically, I am finding identities are changing when I don't expect (or
want) them to. (For reference I am using Fedora Core 2 Test 2 here.) In the
first example, I read that "The SELinux user identity can only be set by
certain TE domains such as the domain for login. ... It is also not set by
the su program." However, by running su, I ended up with the following
process tree:

 1599 charles:staff_r:staff_t                  -bash
 1641 charles:staff_r:staff_su_t               su -l
 1642 root:sysadm_r:sysadm_t                   -bash
 1707 root:sysadm_r:sysadm_t                   ps -AZ

If I am reading this right, this contradicts the behavior expected in the
previous statement. Have I misunderstood what is happening here?

Secondly, and more directly related to my work, I have a new service that I
wish to run in its own security context. The server is started using rc.d
scripts. Because the server expects to have a home directory in which it can
freely mess around (and because the server should probably not run as root
in any case) I wished to assign  it its own Linux user identity. I do this
by using the --user flag in the rc.d  fuctions script, which just causes the
server to start through a call to "su ... -c". My hope was that I could get
the server running with the new Linux username, but keeping the
system_u:system_r context (just like all the other servers).  Instead, the
server gets transitioned to the user_u:user_r context. I imagine I could
solve this problem by creating a new SELinux user identity that matched the
Linux identity and then assigning it the system_r role (in which case I
wouldn't run under system_u, but I could run under the system_r role, which
would suffice). However, I would prefer to understand what actions were
going on and see if I could control them. I note that there are several
other daemons running under separate Linux usernames but which keep the
system_u identity. What is the difference here?

Sorry about the long post and thanks for any and all help.

Later,
Charles




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
