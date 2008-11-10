Message-ID: <cadfc0e40811100834j4945c30eu13d8b255f9fad32f@mail.gmail.com>
Date: Mon, 10 Nov 2008 10:34:54 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: Label Translation on Fedora 9
Cc: "Joe Nall" <joe@nall.com>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Andy Warner" <warner@rubix.com>, selinux@tycho.nsa.gov
In-Reply-To: <200811101126.13750.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <490EE548.60400@rubix.com> <200811101056.57415.paul.moore@hp.com>
	 <cadfc0e40811100810y539d09cege4fd2c2fa064d3c2@mail.gmail.com>
	 <200811101126.13750.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 10, 2008 at 10:26 AM, Paul Moore <paul.moore@hp.com> wrote:
> On Monday 10 November 2008 11:10:49 am Xavier Toth wrote:
>> On Mon, Nov 10, 2008 at 9:56 AM, Paul Moore <paul.moore@hp.com> wrote:
>> > On Sunday 09 November 2008 1:26:58 pm Joe Nall wrote:
>> >> Sorry about the big delay in closure on this. We have been very
>> >> busy trying to build a demonstrable Fedora based MLS/X system to
>> >> run our applications on. The demo was last week in London and we
>> >> have some time to upstream our changes this month. That includes
>> >> adding combination constraints, label-to-color mapping and
>> >> migration tools to mcstransd and pushing it into a public repo for
>> >> community consideration.
>> >
>> > Cool.  Do the current X/metacity patches support label coloring?
>>
>> No.
>
> Okay, just out of curiosity is this being worked on?  Also, what other
> applications are there for label coloring?
>
> I'm just trying to understand things a little better.
>
> --
> paul moore
> linux @ hp
>

Once we get color support in Joe's version of mcstrans I'll integrate
color support into metacity and openbox and then work on getting it
upstreamed. Aside from mcstrans modifications this will require
libselinux changes to implement new apis to get color based on
context. I'm not sure what other applications there are for label
coloring.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
