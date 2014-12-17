Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBHDX3ec018938
 for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2014 08:33:03 -0500
Message-ID: <549185F5.6080500@redhat.com>
Date: Wed, 17 Dec 2014 08:32:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 eric gisse <jowr.pi@gmail.com>
Subject: Re: open_init_pty function?
References: <CAHZ_Ajs3ah9JcoxdmUr54-AzsN8ksP81HMpMfi-egTx4=Hzt-w@mail.gmail.com>	<548EE841.6090402@tresys.com>
 <CAHZ_AjsDfahUETESHYkkvMnzQLoOvEd7hKN8F_+Y-a11Z7E-tQ@mail.gmail.com>
 <548F27DA.2020002@tresys.com>
In-Reply-To: <548F27DA.2020002@tresys.com>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 12/15/2014 01:26 PM, Christopher J. PeBenito wrote:
> On 12/15/2014 11:33 AM, eric gisse wrote:
>> Thanks, that helps a lot. The consensus on what you said basically
>> boils down to "enforcing a new tty ensures that, among other things,
>> the executed process can't play games with the calling domain's file
>> descriptors".
>>
>> I'm a bit fuzzy on how to exploit this and how big of a deal it could
>> be in practice because, in theory, selinux should keep a process I
>> spawn from tinkering with anything directly.
> Consider the bash session the admin is running.  If the admin runs
> su/sudo, the daemon can simply read the terminal to capture the admin's
> password when they enter it.  Similarly, as the admin runs programs, the
> daemon could write to the terminal to inject data into the admin
> processes.  You could deny this terminal access to close this hole, but
> the trade off is that you lose any early messages (error or otherwise)
> the daemon sends when you run_init.
>
>
>
>> This does, by the way, answer the question of why the redhat patch
>> that disables this behavior was either never submitted or never
>> accepted upstream.
>>
>> Though I wonder why redhat is OK with disabling this, given the ease
>> of implementing this additional security measure. I only got pulled
>> into this because the stock run_init does not properly pass status
>> codes.
>>
>> I was thinking that entire code block could go away because the way
>> the utility was worded, was that it was providing a ptty for init
>> scripts because the init scripts *needed* the ptty rather than being
>> as some value of exec STDIO filtering / FD protection / whatever.
>>
>> I was asking both gentoo and debian maintainers of this as well as
>> other random folks and nobody saw the value of this. I still have a
>> hard time wrapping my head around the problem this solves but the cost
>> of doing it this way is zero, as long as a tiny little bit of work
>> (that debian already did) to pass status codes is done.
>>
>> Which is all I wanted in the first place.
>>
>> run_init likes to clobber status codes, which breaks my puppet.
>>
>>
>> On Mon, Dec 15, 2014 at 7:55 AM, Christopher J. PeBenito
>> <cpebenito@tresys.com> wrote:
>>> On 12/15/2014 6:32 AM, eric gisse wrote:
>>>> In tracking down some related issues, the subject of the helper
>>>> program /usr/sbin/open_init_pty came up.
>>>>
>>>> This gets called by run_init as the final step for running a program
>>>> in the initrc context, like this:
>>>>
>>>> if (execvp("/usr/sbin/open_init_pty", argv)) {
>>>>   perror("execvp");
>>>>   exit(-1);
>>>> }
>>>>
>>>> The context for this problem is the discovery that open_init_pty
>>>> doesn't play well with others by refusing to pass along return codes.
>>>> Eg, run_init from stock will always return 0.
>>>>
>>>> Debian fixes this problem by fixing open_init_pty to return status
>>>> codes, redhat bypasses it in favor of execvp(), and gentoo uses stock
>>>> and is evaluating its' options.
>>>>
>>>> What I'm trying to figure out is, is the function of open_init_pty in
>>>> the general sense.
>>>>
>>>> Init scripts don't generally get a pty, so I don't understand the
>>>> necessity and hope someone here can shed a little light on this.
>>> Most daemons will print early error messages before reopening their
>>> stdin/out/err to /dev/null.  The purpose of open_init_pty is to provide
>>> an isolated stdin/out/err for the init scripts and daemons.  Without it,
>>> we'd have to allow all daemons to read/write sysadm/unconfined
>>> terminals, which opens those highly-privileged users to attack.
>
Luckily with systemd we no longer have to worry about daemons gaining
access to admin terminals, since they are no longer children of the
admin process.
