Subject: Re: [RFC] Split up policycoreutils
To: Chris PeBenito <pebenito@ieee.org>, SELinux <selinux@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3c579f68-4125-c2e2-a2d9-6d801f7f7de9@tycho.nsa.gov>
Date: Mon, 24 Oct 2016 09:21:06 -0400
MIME-Version: 1.0
In-Reply-To: <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/24/2016 09:13 AM, Stephen Smalley wrote:
> On 10/22/2016 09:44 AM, Chris PeBenito wrote:
>> On 10/21/16 13:47, Stephen Smalley wrote:
>>> policycoreutils started life as a small set of utilities that were
>>> necessary or at least widely used in production on a SELinux system.
>>> Over time though it has grown to include many optional components, and
>>> even within a given subdirectory (e.g. sepolicy) there seem to be a
>>> number of components that should be optional (e.g. the dbus service).
>>> I'd like to propose that we move a number of components out of
>>> policycoreutils into their own top-level subdirectory (possibly grouping
>>> some of the related ones together).
>>
>> I'm not sure where the main part of sepolicy should go, but it would be
>> nice to split it out since it depends on setools which has heavier
>> dependencies than a core system package should typically have IMO
>> (NetworkX, which pulls in scipy, numpy, matplotlib, etc.)
> 
> I would be in favor of that too, but hesitated to do so because it would
> require moving audit2allow and semanage out of policycoreutils as well.
> Fedora does package those as part of policycoreutils-python (along with
> sepolgen).  Arguably audit2allow isn't necessary for production (but
> many users of SELinux in Linux distributions rely on it), but semanage
> is more fundamental these days.
> 
> However, if people are open to moving sepolicy, audit2allow, and
> semanage, possibly combining them with sepolgen in a new
> subdirectory/package, then we could explore that.

We'd also need to move chcat, since it imports seobject.  However, on
that topic, is there any reason to retain chcat?  It was created for the
original discretionary MCS model and I'm not sure it is used anymore by
anyone.
