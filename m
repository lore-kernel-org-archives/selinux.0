MIME-Version: 1.0
In-Reply-To: <20150528194128.GI26667@tamriel.snowman.net>
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
 <CAFPpqQGW=-pmSOfyppL1Q8uZLP=0ikpniQHRMUF-41dFXSdJiQ@mail.gmail.com>
 <55676C62.2010309@tycho.nsa.gov>
 <CAFPpqQHx4ONAyia4LoFji7AM07xUqVhXNfzvrhJbm4kZmnanOg@mail.gmail.com>
 <20150528194128.GI26667@tamriel.snowman.net>
Date: Thu, 28 May 2015 14:43:13 -0500
Message-ID: <CAFPpqQHiJrOMC=jgs-rTB1QQy4qc8Ni65vTRE2OjDn4Ux63jYw@mail.gmail.com>
Subject: Re: postgresql policy
From: Ted Toth <txtoth@gmail.com>
To: Stephen Frost <sfrost@snowman.net>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Absolutely I'll share it when I'm happy with it.

Ted

On Thu, May 28, 2015 at 2:41 PM, Stephen Frost <sfrost@snowman.net> wrote:
> Ted,
>
> Any chance that module will be released under the PostgreSQL license
> (BSD-like)?  We'd certainly like to see what those are doing and I do
> wonder if we could use the hooks instead, if the SELinux community feels
> that's a worthwhile approach.
>
> Thanks!
>
> * Ted Toth (txtoth@gmail.com) wrote:
>> Sorry these are in a module I've developed.
>>
>> Ted
>>
>> On Thu, May 28, 2015 at 2:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > On 05/28/2015 03:10 PM, Ted Toth wrote:
>> >> Unfortunately it is the latter. Here's an example of what you can do:
>> >>
>> >> CREATE TABLE reports (
>> >>     id integer NOT NULL,
>> >>     report json,
>> >>     message_id integer NOT NULL,
>> >>     location geometry(Point),
>> >>         security_label text DEFAULT sepostgres_getpeercon()
>> >> );
>> >>
>> >> CREATE POLICY
>> >>   check_report_insert_selinux ON reports FOR INSERT
>> >>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
>> >> sepostgres_getpeercon(), 'insert'));
>> >>
>> >> CREATE POLICY
>> >>   check_report_delete_selinux ON reports FOR DELETE
>> >>   USING (sepostgres_check_row_perm(reports.security_label,
>> >> sepostgres_getpeercon(), 'delete'));
>> >>
>> >> CREATE POLICY
>> >>   check_report_update_selinux ON reports FOR UPDATE
>> >>   USING (sepostgres_check_row_perm(reports.security_label,
>> >> sepostgres_getpeercon(), 'update'))
>> >>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
>> >> sepostgres_getpeercon(), 'update'));
>> >>
>> >> CREATE POLICY
>> >>   check_report_select_selinux ON reports FOR SELECT
>> >>   USING (sepostgres_check_row_perm(sepostgres_getpeercon(),
>> >> reports.security_label, 'select'));
>> >>
>> >> I'm hoping that between DAC, postgresql DAC, selinux policy and RLS
>> >> policy we can get something that's secure enough for our purposes.
>> >
>> > Pardon my ignorance, but are the sepostgres_*() functions something you
>> > have implemented or something in the existing sepgsl or postgres code?
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
