Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l95G6rtO021688
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 12:06:53 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l95G6lT0008500
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 16:06:47 GMT
Received: by wr-out-0506.google.com with SMTP id c8so432447wra
        for <selinux@tycho.nsa.gov>; Fri, 05 Oct 2007 09:06:32 -0700 (PDT)
Message-ID: <481038a0710050906m581c4841l6679e4e398b25f52@mail.gmail.com>
Date: Sat, 6 Oct 2007 00:06:31 +0800
From: Ken <spng.yang@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: puzzles about hidden_def and hidden_proto
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3341_18391950.1191600391208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3341_18391950.1191600391208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> They came from Ulrich Drepper.
> See:
> http://people.redhat.com/drepper/dsohowto.pdf <http://people.redhat.com/drepper/dsohowto.pdf>

> They are to create and use private definitions of the symbols for calls
> to them within the shared library to avoid relocations on them, as that
> has a cost and is usually unnecessary (you typically don't need to
> permit interposition on such calls).  You declare them with
> hidden_proto() in a header file (see src/*_internal.h), include those
> headers in the .c files that use those symbols, and put a hidden_def()
> in the .c file after the definition.

hi, Stephen, thanks for your reply

sorry for reply late, i have learned ulrich's paper, and i think i
understand what hidden_* macro means, but there were still two questions,
whick i dont understand:

1
IMHO, the implementation of hidden_proto() is a kind of "symbol rename"
trick, we can continue to refer to the symbol as fct in the source, but
it will be named fct_internal in the asm.

but i don't understand who make the trick happened? GCC?

it's not a grammar of C, i wonder why:

extern __typeof(OLD) OLD asm(NEW)

can rename OLD to NEW?

2
what are the difference between this "rename" trick and gcc "alias"
attribute?

why not use "alias" in hidden_proto()


thans in advance for any hints

------=_Part_3341_18391950.1191600391208
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<pre>&gt; They came from Ulrich Drepper.<br>&gt; See:<br><a href="http://people.redhat.com/drepper/dsohowto.pdf">&gt; http://people.redhat.com/drepper/dsohowto.pdf</a><br><br>&gt; They are to create and use private definitions of the symbols for calls
<br>&gt; to them within the shared library to avoid relocations on them, as that<br>&gt; has a cost and is usually unnecessary (you typically don&#39;t need to<br>&gt; permit interposition on such calls).  You declare them with
<br>&gt; hidden_proto() in a header file (see src/*_internal.h), include those<br>&gt; headers in the .c files that use those symbols, and put a hidden_def()<br>&gt; in the .c file after the definition.<br><br>hi, Stephen, thanks for your reply
<br><br>sorry for reply late, i have learned ulrich&#39;s paper, and i think i <br>understand what hidden_* macro means, but there were still two questions, <br>whick i dont understand:<br><br>1 <br>IMHO, the implementation of hidden_proto() is a kind of &quot;symbol rename&quot; 
<br>trick, we can continue to refer to the symbol as fct in the source, but <br>it will be named fct_internal in the asm. <br><br>but i don&#39;t understand who make the trick happened? GCC?<br><br>it&#39;s not a <span class="djen">
<span>grammar of C, i wonder why:<br><br>extern __typeof(OLD) OLD asm(NEW)<br><br>can rename OLD to NEW?<br><br>2<br>what are the difference between this &quot;rename&quot; trick and gcc &quot;alias&quot; <br>attribute?<br>
<br>why not use &quot;alias&quot; in hidden_proto()<br><br><br>thans in advance for any hints<br></span></span></pre>

------=_Part_3341_18391950.1191600391208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
