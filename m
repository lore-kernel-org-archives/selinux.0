MIME-Version: 1.0
In-Reply-To: <555B62C9.5020808@tycho.nsa.gov>
References: <CAFPpqQF4RPxtJZcdDB_2yke_L+hX4vSk98vOzeFt-EVfznu3+g@mail.gmail.com>
 <555B62C9.5020808@tycho.nsa.gov>
Date: Tue, 19 May 2015 11:56:27 -0500
Message-ID: <CAFPpqQF8oMkJ6_BK8z1VGDFmNq3MC6VJZ+HnOBusmRa3tMW0yA@mail.gmail.com>
Subject: Re: exec'ing new process with different type and MLS level
From: Ted Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Got it, thanks.

Ted

On Tue, May 19, 2015 at 11:20 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/19/2015 11:48 AM, Ted Toth wrote:
>> I've got a process that runs at SystemHigh who's type has lots of mac
>> privileges call it x_t  that execs (calling fork, setexeccon and then
>> execv) other processes in a less privileged type call it y_t and at
>> 'lower' levels. Between the fork and exec I also close all of the file
>> descriptor 0 to maxfd. The issue is that there are MLS constraint AVCs
>> generated for the y_t 'use' access of the fd for ld.so because it is
>> labeled x_t:SystemHigh. Since I did the setexeccon to y_t I'd have
>> thought that ld.so would have been opened as y_t. What am I missing
>> here?
>
> Kernel opens ld.so before the credential change, e.g. see:
> http://marc.info/?l=linux-security-module&m=130339623211102&w=2
>
> There were patches floated to change that behavior but it was
> controversial and would affect user-visible behavior so it would at
> least need some kind of compatibility switch.
>
> I think you either have to allow it or have your privileged process
> first invoke a statically linked "gate" executable that then invokes the
> real program so that ld.so is re-opened in the right context.
>
>
>
>
