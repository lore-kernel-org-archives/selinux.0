Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5LFSWrT002853
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 11:28:32 -0400 (EDT)
Received: from mail.idtweb.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5LFSLNg024409
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 15:28:21 GMT
Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Joshua D. Guttman disp: current'" <guttman@mitre.org>
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>, <selinux@tycho.nsa.gov>,
   "'Amy L Herzog'" <aherzog@mitre.org>
Subject: RE: Fedora Core 2 setools RPM
Date: Mon, 21 Jun 2004 11:28:29 -0400
Message-ID: <007201c457a4$67b25510$4d0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <nhafz8pjabe.fsf@malabar.mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

guttman@malabar.mitre.org wrote:
>>   Filters on that analysis make the analysis practical, and the most
>>   important filters we have learned are interim types (i.e.,
>>   "trusted" types), object classes, and permissions and permissions
>>   weights.
> 
> Could I ask you please to explain what you mean by these terms?

As a starting point, look at the GUI and help file for apol's information flow
analysis.  I'm sure our help files are not the best, but performing the analysis
should make these terms meaningful in the context of our tool.  The "trusted"
types (I think the GUI calls them "excluded") is by far the most important
filter, as it allows you to exclude certain intermediate types from the analysis
of a given flow.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
