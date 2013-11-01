Message-ID: <52740796.5090806@tycho.nsa.gov>
Date: Fri, 01 Nov 2013 15:57:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Gabriele Scotti <gabriele.sct@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Android emulator
References: <CALQuvJCYEZky6kT6DkSpDB9pj_07yHe7cP4cUdZPd5mpwuawEw@mail.gmail.com>
In-Reply-To: <CALQuvJCYEZky6kT6DkSpDB9pj_07yHe7cP4cUdZPd5mpwuawEw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/01/2013 03:42 PM, Gabriele Scotti wrote:
> Dear Sirs,
> 
> I am writing to enquire about the android emulator behavior: I'm using the AOSP
> master branch with the SE for Android modifications and I'm trying to place
> restrictions on what application can use the bind channel.
> I have two custom application in the untrusted domain that can communicate
> each other and I want to block this communication, so I modified the file
> app.te by removing the binder call from appdomain to appdomain but they can
> still communicate.
> I should like to know if I can do this with the emulator or there are
> restrictions, otherwise I assume that I'm writing a wrong policy.

Questions specific to SE for Android should go to the seandroid-list,
which was split off about a year ago from the regular selinux list.
Subscribe by sending 'subscribe seandroid-list' in the body of an email
to majordomo@tycho.nsa.gov and then post to seandroid-list@tycho.nsa.gov.

With regard to your question though, many forms of communication in
Android are indirect via the system_server, which all apps are expected
to be allowed to call via binder.  Thus, even if you cut off direct
binder calls between two app domains, they can likely still send Intents
and such via the system_server.

Strongly isolating apps is more likely to be achieved either by
leveraging the multi-user support and installing the apps under
different user accounts, or by implementing your own container solution
as has been done by others (e.g. KNOX, Cells).





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
