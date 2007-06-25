Date: Sun, 24 Jun 2007 18:20:17 -0700 (PDT)
From: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Question on security_load_policy
To: Nagendra Tomar <tomer_iisc@yahoo.com>, SELinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <994059.5156.qm@web53704.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-257857369-1182734417=:36431"
Message-ID: <714965.36431.qm@web53711.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-257857369-1182734417=:36431
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Nagendra Tomar <tomer_iisc@yahoo.com> wrote: In the security_load_policy() function, for the not-first-time policy load case (ss_initialized is true) what is the significance of cloning the existing sidtab and then updating the contexts of all the sidtab entries (sidtab_map_remove_on_error) ?
            
 Why can't we just drop the table and then let the new table be populated dynamically as and when new contexts are looked up. As this is how the original sidtab was populated in the first place.

Tomar>> I see the need for it to support existing processes 
                which already have the SID stored in their 
                task_struct.  If we re-create SIDs these existing SIDs 
                will not be relevant.

I can see that it might have some performance benefits in terms of  not requiring to create SIDs for the security contexts that were already present in the current sidtab, but is that overhead really worth this effort.  

If we remove the code that does the cloning and conversion of contexts (sidtab_map and sidtab_map_remove_on_error calls)
we will have uniform code for both the first-time and the not-first-time policy load case. IMHO, that will result in  slightly cleaner security_load_policy function.  
        If we do that, we will have to call policydb_load_isids() also for the not-first-time poliy load case.

Thanx,
Tomar
          

---------------------------------
  Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for your free account today.

       
---------------------------------
 Yahoo! Answers - Get better answers from someone who knows. Tryit now.
--0-257857369-1182734417=:36431
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br><b><i>Nagendra Tomar &lt;tomer_iisc@yahoo.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> In the security_load_policy() function, for the not-first-time policy load case (ss_initialized is true) what is the significance of cloning the existing sidtab and then updating the contexts of all the sidtab entries (sidtab_map_remove_on_error) ?<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  <br>&nbsp;Why can't we just drop the table and then let the new table be populated dynamically as and when new contexts are looked up. As this is how the original sidtab was populated in the first place.<br><br>Tomar&gt;&gt; I see the need for it to support existing processes <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; which already have the SID stored in their <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; task_struct.&nbsp; If
 we re-create SIDs these existing SIDs <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; will not be relevant.<br><br>I can see that it might have some performance benefits in terms of&nbsp; not requiring to create SIDs for the security contexts that were already present in the current sidtab, but is that overhead really worth this effort.&nbsp; <br><br>If we remove the code that does the cloning and conversion of contexts (sidtab_map and sidtab_map_remove_on_error calls)<br>we will have uniform code for both the first-time and the not-first-time policy load case. IMHO, that will result in  slightly cleaner security_load_policy function.&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  If we do that, we will have to call policydb_load_isids() also for the not-first-time poliy load case.<br><br>Thanx,<br>Tomar<br><div>          </div><hr size="1">  Yahoo! Mail is the world's favourite email. Don't settle for less, <a
 href="http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html">sign up for your free account today</a>.</blockquote><br><p>&#32;


      <hr size=1> 
Yahoo! Answers - Get better answers from someone who knows. <a
href="http://uk.answers.yahoo.com/;_ylc=X3oDMTEydmViNG02BF9TAzIxMTQ3MTcxOTAEc2VjA21haWwEc2xrA3RhZ2xpbmU">Try
it now</a>.
--0-257857369-1182734417=:36431--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
