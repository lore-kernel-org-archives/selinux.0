MIME-Version: 1.0
In-Reply-To: <CAFUy1TzNKNWDACcXtBn05-CMkxyZzGNTQGNHyjt+XFPAoUQ-3Q@mail.gmail.com>
References: <CAFUy1TzNKNWDACcXtBn05-CMkxyZzGNTQGNHyjt+XFPAoUQ-3Q@mail.gmail.com>
Date: Tue, 28 Aug 2012 02:09:42 -0700
Message-ID: <CAFUy1TwvBNP9UBTK39DRWg5LNnf6tA2UJYuBpPP548oK0GrZxg@mail.gmail.com>
Subject: selinux context_new return value question
From: Gaurav Kumar <gk@pivotalsecurity.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

According to http://linux.die.net/man/3/context_new, "On success, zero
is returned" but none of the functions mentioned return 0. They are
all returning const char * or void. Can someone please clarify in
which case 0 will be returned? In other words, how can I find out if
call to context_new succeeded?

Thanks,
Gaurav

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
