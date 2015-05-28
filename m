MIME-Version: 1.0
In-Reply-To: <55676482.6000302@tycho.nsa.gov>
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
Date: Thu, 28 May 2015 14:10:55 -0500
Message-ID: <CAFPpqQGW=-pmSOfyppL1Q8uZLP=0ikpniQHRMUF-41dFXSdJiQ@mail.gmail.com>
Subject: Re: postgresql policy
From: Ted Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Unfortunately it is the latter. Here's an example of what you can do:

CREATE TABLE reports (
    id integer NOT NULL,
    report json,
    message_id integer NOT NULL,
    location geometry(Point),
        security_label text DEFAULT sepostgres_getpeercon()
);

CREATE POLICY
  check_report_insert_selinux ON reports FOR INSERT
  WITH CHECK (sepostgres_check_row_perm(reports.security_label,
sepostgres_getpeercon(), 'insert'));

CREATE POLICY
  check_report_delete_selinux ON reports FOR DELETE
  USING (sepostgres_check_row_perm(reports.security_label,
sepostgres_getpeercon(), 'delete'));

CREATE POLICY
  check_report_update_selinux ON reports FOR UPDATE
  USING (sepostgres_check_row_perm(reports.security_label,
sepostgres_getpeercon(), 'update'))
  WITH CHECK (sepostgres_check_row_perm(reports.security_label,
sepostgres_getpeercon(), 'update'));

CREATE POLICY
  check_report_select_selinux ON reports FOR SELECT
  USING (sepostgres_check_row_perm(sepostgres_getpeercon(),
reports.security_label, 'select'));

I'm hoping that between DAC, postgresql DAC, selinux policy and RLS
policy we can get something that's secure enough for our purposes.

On Thu, May 28, 2015 at 1:54 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/28/2015 12:52 PM, Ted Toth wrote:
>> The ref policy contains a number of sepgsql_ types that are specific
>> to the sepgsql postgresql module. The sepgsql module was written to
>> support a postgresql security patch that was never accepted by the
>> upstream. Now postgresql has gone in a different direction security
>> wise adding row level security (RLS). I've been working on developing
>> RLS policy to label rows on insert and update and to check access
>> perms on select. I've tried using the sepgsql module in the RLS policy
>> but have come to the conclusion that because it was not designed for
>> this purpose it is not usable. So I'd like to suggest that these types
>> be moved out of the postgresql policy possibly into their own module
>> although I personally think they have little if any use.
>
> Should probably post a rfc patch to refpolicy list.
>
> On a different note, does this RLS implementation have any SELinux
> integration or is it just the typical "let's implement our own custom
> policy engine in the database manager and not link it in any way to the
> OS security model" approach?  Pity if it is the latter.
>
>
