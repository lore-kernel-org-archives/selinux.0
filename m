Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0REVgPT007878
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2009 09:31:42 -0500
Received: from flower.research.telcordia.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0RESfoA016140
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2009 14:28:41 GMT
Received: from [127.0.0.1] (vpntnlB19.research.telcordia.com [128.96.59.19])
	by flower.research.telcordia.com (8.14.2/8.14.2) with ESMTP id n0REURh4025343
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2009 09:30:28 -0500 (EST)
Message-ID: <497F1AC7.5030409@research.telcordia.com>
Date: Tue, 27 Jan 2009 09:31:35 -0500
From: Sanjai Narain <narain@research.telcordia.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Mitigating SQL injection attacks with access-control
References: <497E7458.90404@research.telcordia.com> <20090127034618.GI8123@tamriel.snowman.net>
In-Reply-To: <20090127034618.GI8123@tamriel.snowman.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen: Thanks for your very informative reply. Best regards. -- Sanjai

Stephen Frost wrote:
> Sanjai,
>
> * Sanjai Narain (narain@research.telcordia.com) wrote:
>   
>> A lot has been written about validating inputs to avoid SQL injection  
>> attacks. Have there been attempts to mitigate such attacks with  
>> access-control policies, perhaps combining those for SELinux and MySQL?  
>> Thanks for any answers. Best regards. -- Sanjai
>>     
>
> I'm not sure how appropriate this if for this list, but, I don't believe
> SELinux and/or MySQL will solve SQL injection issues.  They may help to
> mitigate the results, but the best approach, by far, is to use proper
> database prepared queries.  By using prepared queries and passing in any
> user-supplied data seperately, you completely remove the SQL injection
> problem.  By using VIEWs and stored procedures you can even simplify the
> queries that are done by the application and provide a kind of API
> between the application and the database that allows both to change
> without requiring a change of the other.
>
> This is a much better solution to any kind of input validation when it
> comes to avoiding SQL injection.  Of course, proper foreign keys in your
> database, proper types, and CHECK constraints, will minimize the
> possibility of garbage/invalid data ending up in your database.  Having
> these database-level checks is really important to maintaining the
> integrity of your data.  Even if you have such checks in your
> application, it often happens that people access the database without
> using the application or while bypassing the application checks.
>
> Regarding SQLinux and MySQL specifically- I don't believe MySQL has
> SELinux hooks built in or available as a patch (if anyone is aware of
> one, I'd be very curious to see it..).  The PostgreSQL community is
> currently evaluating an SELinux patch (SE-Postgres) to add row-level
> security, etc, to the core PostgreSQL distribution.  If you're
> interested in an open source RDBMS with row-level security and SELinux
> hooks, you might start a discussion on the pgsql-general list at
> http://www.postgresql.org/community/lists/.
>
> 	Thanks,
>
> 		Stephen
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
