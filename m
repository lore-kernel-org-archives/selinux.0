Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA07656
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 15:08:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA13314
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 20:08:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil  with ESMTP id UAA13310
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 20:08:23 GMT
Date: Tue, 6 Feb 2001 15:08:19 -0500 (EST)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200102062008.PAA04491@coalstove.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: Division of Labor?
Cc: crusader@linuxgames.com
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

It would be a mistake to view the TODO list, which may be seen at
<http://www.nsa.gov/selinux/todo.html>, as a comprehensive list.  It is
more a list of high priority items to further the project.  Many other
tasks such as porting to other architectures and constructing policies
for complex (particularly server or shared data) applications are good
candidates for people looking for something to contribute.

Feedback about problems installing the system, or ways to ease the job
of installing the system, or experiences in using the system would also
help us a lot.

External patches are always welcome and we encourage people to post
patches to this list.  It has always been our intention to try and
incorporate external patches into the work we're distributing, but
being a large government agency has its disadvantages as well as
advantages.  One disadvantage is that there is a lot of government
contract law complicating our interaction with external developers.
One advantage is that we have a legal staff that can make sense of it
all so our team doesn't have to try.  We expect to have those issues
clarified and resolved soon by our crack team of lawyers.

Of course, the fact that the code is GPLed allows other parties to
extend our work, and we in general welcome that.  Although, certainly
for general extensions rather than site specific work, we would hope
that external developers would want to work in close coordination with
us rather than create a separate project.

crusader@linuxgames.com wrote:
> What's the current division of labor for knocking out the remaining
> portions of the TODO list (http://www.nsa.gov/selinux/todo.html)?
> 
> How are external patches being evaluated?
> 
> Also, I'm assuming that the parties involved would not object to
> a third party expanding on the SE Linux distribution themselves,
> as the changes were released under the GNU General Public License.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
