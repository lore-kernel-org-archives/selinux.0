Message-Id: <200404152143.i3FLhvJx021847@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "SELinux List" <SELinux@tycho.nsa.gov>, <fedora-selinux-list@redhat.com>
Subject: ANN: Tresys Setools 1.3
Date: Thu, 15 Apr 2004 17:44:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Setools version 1.3 has been released. It is available from
http://www.tresys.com/selinux/ and the selinux cvs repository on
SourceForge. This is a major new feature release that includes:

- Two new commandline tools for finding and replacing file contexts. The
tools findcon and replcon can recursively search for files with contexts
that match search strings. The search strings can specify complete contexts,
partial contexts, and shell globbing style wildcards. Replcon will then
replace the context or part of the context. These tools fill an important
gap for the administration of SElinux systems and for the analysis of
SELinux policies. These tools are different from restorecon and chcon
because they can recursively search directories and different from setfiles
because they can set arbitrary contexts.

- Seaudit now supports the creation of multiple views of the same audit log.
This allows the user to view the results from multiple audit log queries at
the same time. In addition, these queries can now be saved so that views can
be recreated later.

- Seaudit also has support for the new audit infrastructure included in the
current NSA release, Fedora Core 2 test 2, and recent Linux kernels. Also,
boolean change messages are supported.

- Apol has complete support for conditional policies, including the viewing
of conditional expressions, policy query and analysis results based on the
current boolean values, and changing the boolean values.

- The information flow analysis in Apol now supports assigning weights to
object class permissions. These weights are used to specify the importance,
or bandwidth, of object permissions so that the information flow analysis
can return flows that contain important permissions first. This will make it
easier for an analyst to find information flows in which they are interested
quickly.

- Seuser will now label newly created home directories.

- Support for version 17 policies is included in all of the tools.

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
