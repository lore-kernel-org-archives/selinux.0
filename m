Message-ID: <55154BA4.3020202@tycho.nsa.gov>
Date: Fri, 27 Mar 2015 08:23:00 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Nick Kralevich <nnk@google.com>
Subject: Re: [PATCH] libsepol: Move secilc out of libsepol
References: <1427398242-13577-1-git-send-email-ykhodorkovskiy@tresys.com>
 <55146AEF.3030909@tycho.nsa.gov>
 <CAFJ0LnHmVoKUMq417A1drJpDDM4+Jk3Jy_4Rkp6nT8GF4eHnqA@mail.gmail.com>
In-Reply-To: <CAFJ0LnHmVoKUMq417A1drJpDDM4+Jk3Jy_4Rkp6nT8GF4eHnqA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/26/2015 07:40 PM, Nick Kralevich wrote:
> On Thu, Mar 26, 2015 at 1:24 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 03/26/2015 03:30 PM, Yuli Khodorkovskiy wrote:
>>> Since the secilc compiler is independent of libsepol, move secilc out of
>>> libsepol. Linke secilc dynamically rather than statically with libsepol.
>>>
>>> - Move secilc source, test policies, docs, and secilc manpage to secilc
>>>   directory.
>>> - Remove unneeded Makefile from libsepol/cil. To build secilc, run make
>>>   in the secilc directory.
>>> - Add target to install the secilc binary to /usr/bin/.
>>> - Create an Android makefile for secilc and move secilc out of libsepol
>>>   Android makefile.
>>> - Add cil_set_mls to libsepol public API as it is needed by secilc.
>>> - Remove policy.conf from testing since it is no longer used.
>>>
>>> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
>>
>> Hmmm...will have to think about how we want to handle this in future
>> releases and in Android.  Presently we generate separate tar releases
>> for each component, not the entire tree, so it introduces a new
>> component that distributions will need to add, and Android would have to
>> introduce an external/secilc project or just keep stuffing it under
>> libsepol for convenience.
> 
> For Android, we could create a new external/selinux project for
> storing a mirror of https://github.com/SELinuxProject/selinux . Having
> separate repositories for libselinux and libsepol has always struck me
> as odd.

Yes, that would likely be helpful for the components that we use
unmodified (libsepol, checkpolicy) and to ease future use of other
components like secilc and audit2allow.  libselinux however is truly a
fork with significant modifications.
