Message-ID: <43BBFA8A.2040601@cornell.edu>
Date: Wed, 04 Jan 2006 11:40:42 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu> <43BBF8C6.1070109@cornell.edu>
In-Reply-To: <43BBF8C6.1070109@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> Let's look at two cases of code that I don't understand:
Here's another one from the user add:

                (rc,exists) = semanage_user_exists_local(self.sh, k)
                if not exists:
                        (rc,exists) = semanage_user_exists(self.sh, k)
                        if not exists:
                                raise ValueError("SELinux user %s is 
already defined." % name)

This doesn't make sense, because you take the same action regardless of 
whether the exist test fails locally, or on the final result (which 
combines policy with local modifications). Hence, you might as well skip 
the first one and go straight to the second one (which will include the 
first one).






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
