MIME-Version: 1.0
In-Reply-To: <1239133257.29028.36.camel@localhost.localdomain>
References: <dd18b0c30904071217x740a809fve1ad3f9fbba140e5@mail.gmail.com>
	 <1239132391.29028.35.camel@localhost.localdomain>
	 <1239133257.29028.36.camel@localhost.localdomain>
Date: Tue, 7 Apr 2009 12:56:37 -0700
Message-ID: <dd18b0c30904071256g4cc2e4e0sf41b431039bff084@mail.gmail.com>
Subject: Re: SELinux userpace compile errors
From: Justin Mattock <justinmattock@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Apr 7, 2009 at 12:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2009-04-07 at 15:26 -0400, Stephen Smalley wrote:
>> On Tue, 2009-04-07 at 12:17 -0700, Justin Mattock wrote:
>> > compiling the userspace tools
>> > I'm receiving some errors:
>> > (the first is just a simple "make" instead of "sudo make")
>>
>> The default top-level target is 'install'.  So you either need to do it
>> as root or specify DESTDIR=/path/to/root for a writable tree.
>>
>> > the second seems to maybe be with the gcc
>> > (which is 4.5.0)
>> >
>> >
>> >
>> > policy_define.c: In function 'set_types':
>> > policy_define.c:1304: error: offset '3' outside bounds of constant string
>> > policy_define.c:1316: error: offset '3' outside bounds of constant string
>> > policy_define.c:1328: error: offset '3' outside bounds of constant string
>>
>> Bug in gcc, already known to gcc folks.
>
> Reference:
> http://gcc.gnu.org/ml/gcc-patches/2009-03/msg01645.html
>
> Who knew that strcmp() was so complex?
>
> --
> Stephen Smalley
> National Security Agency
>
>

cool thanks for the url.
(I'll have to recompile gcc)
as for the error itself(as an example)
just compiled libc and noticed
this error(but with libc it was treated as a warning).

in any case as long as people are aware
of the situation.

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
