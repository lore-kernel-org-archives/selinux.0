Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88DklVO018982
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 09:46:47 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88DkNX5029750
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 13:46:23 GMT
Received: by py-out-1112.google.com with SMTP id 39so694869pyu
        for <selinux@tycho.nsa.gov>; Fri, 08 Sep 2006 06:46:46 -0700 (PDT)
Message-ID: <4501743A.30808@kaigai.gr.jp>
Date: Fri, 08 Sep 2006 22:46:34 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Joshua Brindle <jbrindle@tresys.com>,
        "James W. Hoeft" <Jim@MagitekLtd.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <6FE441CD9F0C0C479F2D88F959B015883C163D@exchange.columbia.tresys.com> <200609082206.02747.russell@coker.com.au>
In-Reply-To: <200609082206.02747.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Friday 08 September 2006 12:10, "Joshua Brindle" <jbrindle@tresys.com> 
> wrote:
>>> I'm confused. Password column is a good example - let's say
>>> the password column is labeled at top secret, then how can a
>>> secret user create a new row? I would assume a password would
>> Well, first of all a secret user can write a top secret column but I
>> think I know what you meant..
> 
> Yes, in the MLS side of things the user can write-up (limited to the high 
> level of their range unless there is an attribute on either the domain or the 
> type to allow going higher).
> 
> But if you have the password labeled with a restrictive type (something 
> equivalent to shadow_t) then it becomes a little more tricky.

When a unauthorized user try to insert a new row into the table which contains
the password column, I think an insert query without password column should be
allowed because this query doesn't write anything to the password column.
So, NULL or a default value of password column will be set on this query.

Because this selection is done by administrator, we cannot say the user touched
the sensitive column. How do you think this behavior?

I hope to explain by an example.
When the table FOOBAR has three columns (ID, NAME, PASSWORD) and user 'KaiGai'
does not have a permission to insert.
The following query (A) and (C) will be failed in this case, because 'KaiGai'
try to set anything into PASSWORD column. But the query (B) will succeed
because he doesn't set anything into there.

(A) insert into FOOBAR(ID, NAME, PASSWORD) values(123, 'KaiGai', 'xyz');
(B) insert into FOOBAR(ID, NAME) values(123, 'KaiGai');
(C) insert into FOOBAR(ID, NAME, PASSWORD) values(123, 'KaiGai', null);

>>> be required, but that either means a secret user cannot read
>>> or cannot write (or can't do either). If that's not the case,
>>> then does that mean the row can be created without a
>>> password? In which case, does that mean only top secret users
>> Probably a trusted stored procedure that has a higher level of access
>> would be used
> 
> Or a trusted SQL client program.  When considering ways of improving the 
> security of database backed web sites my best ideas involved having multiple 
> programs doing database access with different contexts.
> 
> For example the PHP script that wants to delete a topic might run a program 
> that takes the user-name and password for the database connection on stdin 
> (which would be used to validate the user's rights to delete the topic), and 
> command-line parameters to specify the forum and topic to be deleted.  That 
> way someone who cracks part of the forum software would only be able to 
> delete topics that their UID is permitted to delete.

I approve with the both ideas.
Anyway, an unauthorized user should not be able to access sensitive data
without passing any trusted procedure. I believe this behavior is general
in SELinux.

> Also for database access I think we want permission for a trusted connection 
> manager to perform connections on behalf of other contexts.  So we need to be 
> able to specify in policy that domain foo_t can connect as bar_t and maybe 
> permit range transitions too.  I expect this to be controversial.  But a very 
> common need for database security is where you start with a front-end process 
> that runs under the same context for all users.  There are several places 
> where the privileges for different users can be separated, the database 
> connection is one of them.
 >
>>> I would also think multiple security queries per database
>>> query would present a significant performance hit (but then
>>> again, that may be the price we have to pay for the added security).
>> Many of the lookups are already going to be done (eg., table, column DAC
>> permissions) and the AVC is pretty fast, I don't think the hit will be
>> significant but I'd be very willing to find out..
> 
> I agree.  Lots of database operations can be CPU intensive, SE Linux checks 
> with the AVC in user-space should not be a factor in overall performance.
> 
> Security Enhanced X is where we will have difficulty in delivering 
> performance.

In addition, PostgreSQL will optimize the query by sorting the conditions
and using index, so the priority of executing functions is low.
The evaluation by SELinux is not done for any rows.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
