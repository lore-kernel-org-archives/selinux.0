MIME-Version: 1.0
In-Reply-To: <CAHC9VhTkBJ4f6Zkeu=Ufae1XHyxVCgfARyj8Hc6yiEgh55Xz-Q@mail.gmail.com>
References: <1495040944-11552-1-git-send-email-sbuisson@ddn.com>
 <CAHC9VhSa_0FnaHpFR9jB4tkV-7p_JxFqRaQGC7+LTkfcmdV7mA@mail.gmail.com>
 <1495116094.5475.4.camel@tycho.nsa.gov>
 <1495120065.5475.10.camel@tycho.nsa.gov>
 <CAHC9VhTkBJ4f6Zkeu=Ufae1XHyxVCgfARyj8Hc6yiEgh55Xz-Q@mail.gmail.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Tue, 23 May 2017 18:29:32 +0200
Message-ID: <CAPkE-bW_dLo2hoE+rA_sOgZnqcZD_9L1RiDvyDBAtxJm3AM5Wg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] selinux: add brief info to policydb
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org,
 Sebastien Buisson <sbuisson@ddn.com>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

2017-05-18 23:49 GMT+02:00 Paul Moore <paul@paul-moore.com>:
> My apologies to you and Sebastien for not reviewing these patches sooner.

It is ok, no problem.
Thanks for all the advice from you and Stephen. I will try to take all
this into account.

As I understand it, I should not give the choice to allocate or not
the string returned by security_policydb_brief(). The initial reason
for this was that Lustre client code is expected to retrieve policy
brief info hundreds or thousands of times per second, so saving on
memory allocation would make sense. So if security_policydb_brief()
necessarily allocates memory for the string returned, and I appreciate
it helps maintenance and avoids complexity, it should not be called so
often.
One way to tackle this is to rely on the notification system: Lustre
client code would call security_policydb_brief() only when it gets a
change notification, and stores the current policy brief info
internally.
Another way could be to add another hook to check policy brief info
validity. It would take a string as an input parameter, and return 0
if it matches the current policy. So Lustre client code would
systematically call this hook, and only call security_policydb_brief()
when the policy has changed, to store the current value internally.

I have recently identified a new need from Lustre client code. We need
to protect against the case where the policy is changed or set in
permissive mode, and then set back to its previous state, to
workaround policy check as carried out on server side based on policy
brief info sent by client. In this scenario, the policy would only be
the expected one by the time the client sends a request to the server
(for instance a file open request), but not after that when SELinux
actually checks the permissions on the client (via
security_file_open() in this example).
A solution to address this could be to add a new parameter to
security_policydb_brief() hook, in the form of a pointer to an integer
giving the current sequence number of the policy. That would
complement the policy brief info, with the notion of change to the
policy. I do not think it is desirable to include the sequence number
in the policy brief info, as it is not the essence of the policy.
Now with this sequence info in mind, the new hook to check policy
brief info validity would only need to check the sequence, instead of
the policy brief string. The current value of the sequence info should
be stored by Lustre internally, and checked after SELinux permission
checks. If a change is detected, Lustre client must stop normal
processing and return an error for the current request.

Thanks,
Sebastien.
