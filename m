Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7TKQQLa029056
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 16:26:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7TKQPet016377
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 20:26:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h7TKQPlq016374 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 20:26:25 GMT
Subject: Re: Type background of SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3563@etsuex1.etsu.edu>
References: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3563@etsuex1.etsu.edu>
Content-Type: text/plain
Message-Id: <1062188749.5432.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Aug 2003 16:25:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-29 at 15:57, Jenkins, Steven wrote:
> "... TE allows the relationship between a subject and its executable to
> be tightly controlled, enabling protection based on the function and
> trustworthiness of code and offering protection against the execution of
> malicious code."
> 
> It's not immediately clear to me how much of a role types really play in
> achieving this protection (beyond a very simple static type check).
> Also, it's not clear to me how rich of a type system is actually
> necessary -- is there a more formal definition of the type system
> somewhere? 

A "type" in TE is simply a security equivalence class for objects; all
objects with the same security properties have the same type.  You could
just as easily refer to it as a "security tag" or "security label".   TE
is simply "the Lampson access matrix organized into equivalence classes
for efficiency", as stated by Earl Boebert.  The security policy writer
can define types to represent specific functional and integrity
properties of executables, label the executables with these types, and
define policies over the ability to execute from these types.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
