Date: Sun, 27 Jan 2002 22:13:08 -0500 (EST)
From: Thomas A Langan <tlangan@dsl.cis.upenn.edu>
To: <SELinux@tycho.nsa.gov>
Subject: Policy Enforcement Question
Message-ID: <Pine.GSO.4.33.0201272204020.3875-100000@codex.cis.upenn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I have a quick conceptual question about the role policies in the Flask
architecture.

When policies are defined by an admin --- using RBAC, TE or a
combination thereof --  and parsed into the system, does rights-checking
at the lowest level occur seperately for each policy defined (and in turn,
seperately for each language such as RBAC or TE) or do all the policies
compile down to an intermediate format that handles all of the languages
and policies transparently?  If the latter, what is the intermediate
representation?


I couldn't find any clear documentation to answer this question -- if it
exists, let me know where it is and I'm sorry about cluttering your
mailbox!

Tom


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
